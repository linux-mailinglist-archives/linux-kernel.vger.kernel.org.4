Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8D62DA71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiKQMOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiKQMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BD7018F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668687185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5j9DmJftbiNuyWuQp4J4DaVBp6LHbVnovAFrJEquk4=;
        b=AyERdWz9WyjvQxT/gdl+RwEQT6Yf1Q2SRkkjWcBRhhCW4j5tADei8vwroOYgXuPFUIIGlL
        vpwAY21lQR6PoZpMxxrP5Z9AJDOQiW63q/4eo0hrpm7WJb5eZcNdphPGX1p2o8ogOD+6Ns
        JdJWb7N2/evjpqHXOhbNiPUtAAl/K9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-UJWfcDZHO6yBGUNSzGMU-g-1; Thu, 17 Nov 2022 07:13:04 -0500
X-MC-Unique: UJWfcDZHO6yBGUNSzGMU-g-1
Received: by mail-wr1-f72.google.com with SMTP id k1-20020adfb341000000b00238745c9b1aso624104wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5j9DmJftbiNuyWuQp4J4DaVBp6LHbVnovAFrJEquk4=;
        b=KdpYVvgfpEgx5AGu5ZiSSGN9mKZ+IOc+XmaP6C7LLTepxYvSGzBGxz2bKSqVPwBSY9
         fWPPfl3gNLT6EAx6QIc9B7IDBwKsq6C8XTADeuKjNmfHHm4sL+g2up2W6afHaIZIEpme
         Of9kSnQ5Pmdh2X+t6V3iN1PGnJ4J7wQ4zS5h8Mm1Uo/xoFk4ZGrPDbsgCs4icxEUJs2w
         5GXdpcBrR3GIxNTmfoDMktwaINYHhk81zvhOKS33cDRJiMiD5nZiSKT+jzz9ozVDBQiY
         48Jd9AqJfrCDsiJASDCQk/rGPCySPtgnBiqRdWlOualGbMUs7gTjAwyJ0QRsNgvb8ZZP
         IQtw==
X-Gm-Message-State: ANoB5plkinVg/gINVQRfW1BYgrIMJmsJQ47iidC3ikjyBgmCLuvY+jbn
        hatSHjvm86Fy8PZSB72nqSAMD89LfGatIoThxqxhnQGWblLiP7QasA7zKnFhYUjEQC7nlJ2T0Z5
        mYN1kF2QkXdcswId7xSxAnoPr
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id d24-20020a1c7318000000b003cfcb16f24amr4940547wmb.182.1668687183284;
        Thu, 17 Nov 2022 04:13:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf45Fdyv1heAo7QA/P1UGM3QqYUDdP9AyD2QFRZJEGDSgoiGR7WkHocJh68ff65K5BiMjVG/Ig==
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id d24-20020a1c7318000000b003cfcb16f24amr4940530wmb.182.1668687183035;
        Thu, 17 Nov 2022 04:13:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003cf7292c553sm1022914wma.13.2022.11.17.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:13:02 -0800 (PST)
Message-ID: <1c43f0836d741a575b4805292d6dfff134ef6225.camel@redhat.com>
Subject: Re: [PATCH] sctp: sm_statefuns: Remove unnecessary
 =?UTF-8?Q?=E2=80=98NULL=E2=80=99?= values from Pointer
From:   Paolo Abeni <pabeni@redhat.com>
To:     Li zeming <zeming@nfschina.com>, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 13:13:01 +0100
In-Reply-To: <20221115015508.3054-1-zeming@nfschina.com>
References: <20221115015508.3054-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2022-11-15 at 09:55 +0800, Li zeming wrote:
> The packet pointer is assigned first. It does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

I'm sorry, but IMHO the commit message is quite unclear, I suggest to
re-phrase to something alike:

"""
The 'packet' pointer is always set in the later code, no need to
initialize it at definition time.
"""

Thanks,

Paolo

