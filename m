Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D676EE21E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjDYMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDYMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1220D319
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682426733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=krc+SiJhBUwO2ug/XwTx3KTJqkkR2CFS+eg5Dz5ylJc=;
        b=GNel7tYtecy0XSojQ9FZCgQu1lm14KPC8XQY1NEnpffzLSVyjYDRvvmeyx/ybELipkrOCI
        NllPj47FEjC+ok1shSg62LsW2PC2BPJf8YyM4AcD+TsFVYzje+MCGXYVwr7E97gGhOV/rp
        eNwM4l0kVZRQCk7bSe2HdiWnSckkFHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-nk5lSKfPN2GL-BR2zna0xg-1; Tue, 25 Apr 2023 08:45:30 -0400
X-MC-Unique: nk5lSKfPN2GL-BR2zna0xg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f18c2b2110so20080895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682426728; x=1685018728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krc+SiJhBUwO2ug/XwTx3KTJqkkR2CFS+eg5Dz5ylJc=;
        b=QNxcqn/ENK8NQ/G/PZ/b+YFIYqG6Pc+I+UUZlhkqStuXzw61EIaZ1eI7xEDRlE2EIr
         ev72YeJYttq14xm+nZjJNw4Ph7azntQr1plrasFMPwv76O7iP0CQfNz69E9sPCCrerd/
         50gKV9DER9F3pgyuUwV2AxT/wGA4BSqkifjSpg+/VccLPxAqVxMWBe4YcLEBnfIaUN69
         fFjRw7itowo0CugpVdDT+pADZ1beoz7c56euwch+ohgkkq2yGvt7LShDI2dJ760gFvDZ
         VH5MiitfraWxxgt+AQFfq0kVVsrF6oyT5Xo9XT4DMJXIHOBi0rADDW06bPakyDYqYu8j
         Y5Gw==
X-Gm-Message-State: AAQBX9f3BS7s1503zXPW5wMcQQ1bWMhhfkssfe1oTFbfm8KKOSZPgz8p
        J9m1Oe+5O47C4UiaD6An3aFzI+qVAPtdCDJwI+/GkNKHLUOG+PHufWJ5sWApd6yvbX8W1CBTQlF
        XqVvEH2wUwmuZEMWI9PPL/HEg
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id z20-20020a05600c221400b003f1987b7a28mr7195384wml.29.1682426728236;
        Tue, 25 Apr 2023 05:45:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIPgn166ZA/wJ8PFmg9nFmKKBjNCYwRGQ/sI+aE3t+loxoVTTzjiSf9BdLyfiT4aA9pr1zIA==
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id z20-20020a05600c221400b003f1987b7a28mr7195359wml.29.1682426727867;
        Tue, 25 Apr 2023 05:45:27 -0700 (PDT)
Received: from redhat.com ([2.55.17.255])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm18301465wmq.20.2023.04.25.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 05:45:27 -0700 (PDT)
Date:   Tue, 25 Apr 2023 08:45:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [PATCH] can: virtio-can: cleanups
Message-ID: <20230425084503-mutt-send-email-mst@kernel.org>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
 <20230424170901-mutt-send-email-mst@kernel.org>
 <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:17:20AM +0200, Marc Kleine-Budde wrote:
> On 24.04.2023 17:09:23, Michael S. Tsirkin wrote:
> > On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> > > Address the topics raised in
> > > 
> > > https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de
> > > 
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > given base patch is rfc this should be too?
> 
> This is an incremental patch that fixes the topics I raised in the
> review of "[RFC PATCH v2] can: virtio: Initial virtio CAN driver.", see
> linked discussion thread.
> 
> regards,
> Marc

and that's fine, just pls put RFC in the subject.

-- 
MST

