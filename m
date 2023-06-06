Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B247240C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjFFLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjFFLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9DB1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686050462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebVF+Max5iyqvwuGYgC/XuMFb8EIbpDHTovot3c/RRY=;
        b=cyMnXLudHHPiF7mVDzaJc+MRWyPBhXKBhwU1+tlDaE+HrefHWHacCYf9+IalYTt0ABf4iC
        G0mMq2Y6fFR1GTjsn2gSqDgdZl9xpDSFgz9XmlebLRp1lOOgHXU5YWM1KGhlncob59JjIj
        L4J61p4L4DFEwnQyEW/+bJyCiMkp0eU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-KXFnyobnNsuQviFbbuTgpw-1; Tue, 06 Jun 2023 07:21:01 -0400
X-MC-Unique: KXFnyobnNsuQviFbbuTgpw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ec325d255so20212585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050460; x=1688642460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebVF+Max5iyqvwuGYgC/XuMFb8EIbpDHTovot3c/RRY=;
        b=HHLGp9ltsYaXgUaAAw5SBrXl1rVHDg2GvaB3cIuesMP4hWtoazlVh7rtnizchPPm7m
         +J9vKYjaJSl0foBaEM5iEUiAQAmdoj8dCkiPd+JZJxsa/TFjtCrtrCEX6DeGuTPcKkrD
         jDO1GP59AWTmK3Cr1RmV7Tq3lWmPMjG7HK9hk8kgay867f6JPfhgU1KrQr7a6/9mFdwG
         p0qGW7zLWNfoKW+zvQ2P0bz+AS9CqR0eWBqV+oGiH564/lyK2H64L15JmtKigGJ9q9nK
         t7rK1EU3xXbOr26bvjqveKm777I14np26Tnfquij+0Sbxq1rD1jYOllwpZB++x+uuzyF
         yoUg==
X-Gm-Message-State: AC+VfDzl2ibf8el2N0k+QFACd38ia39Dufro6dCmqSttuzw4RbGZ/Hop
        r3hnirk1CL6Dr/KCrxa0syS28d3Jl9Uy7xv5So2mwFcM4vHVUEBErgC2PN9Odb4wY2DooSEX+wW
        aP5x9aPfntAHG7Y4zCCk0eOqA
X-Received: by 2002:a05:620a:6193:b0:75e:c678:d49e with SMTP id or19-20020a05620a619300b0075ec678d49emr1858911qkn.2.1686050460550;
        Tue, 06 Jun 2023 04:21:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70txRJXtKwBAapUKNxYE7fFjx2DvuV1I+j+FBbtbexPBQVPSmMnzDDrhyGWaEdkJ93Jp/QZw==
X-Received: by 2002:a05:620a:6193:b0:75e:c678:d49e with SMTP id or19-20020a05620a619300b0075ec678d49emr1858890qkn.2.1686050460286;
        Tue, 06 Jun 2023 04:21:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-89.dyn.eolo.it. [146.241.114.89])
        by smtp.gmail.com with ESMTPSA id q21-20020ae9e415000000b0075d405f4bdcsm255424qkc.125.2023.06.06.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:21:00 -0700 (PDT)
Message-ID: <d61eea76bfff30ced8462aeb98409caa9b2232a2.camel@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] mac_pton: Clean up the header inclusions
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 06 Jun 2023 13:20:57 +0200
In-Reply-To: <ZH7xgznYTfyLIslo@corigine.com>
References: <20230604132858.6650-1-andriy.shevchenko@linux.intel.com>
         <ZH7xgznYTfyLIslo@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-06 at 10:42 +0200, Simon Horman wrote:
> On Sun, Jun 04, 2023 at 04:28:58PM +0300, Andy Shevchenko wrote:
> > Since hex_to_bin() is provided by hex.h there is no need to require
> > kernel.h. Replace the latter by the former and add missing export.h.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Hi Andy,
>=20
> is there a tool that you used to verify this change?

I guess build testing it should suffice ;)

/P

