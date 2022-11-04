Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2B619FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKDSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiKDSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:23:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941F2650;
        Fri,  4 Nov 2022 11:23:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso9012735pjc.0;
        Fri, 04 Nov 2022 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+T+zRU50EyoybWvV9puA2CX5+7utUDve2uCmkWDcVU=;
        b=B2rp+yRal5VNyXSQzC2EFgINuD2kzVlVD2TOyfvjlWRzcAb4YSFfMY4ye+pMbKRllC
         v2BUcdOoHBp/xD2OvPQ5xZy/OZuiBwALvcBl0w9iEJiDDDelF4obf/bXEy+9rcUkxXzr
         F1O/VrabWitRCKzGUHE9RiwT3nI0KUrAFAThs3BwGfcL1QJpuyXvGenl5+9/qxfyzYNg
         CsHEHLz4mh9zakPLY/u8tsb6Ml44itWPbePiC7gHgmstF/tA+dzZkK06a5Pp5v9CAD7w
         oZh70tyhggS/PDYgoMPJq/NrUXl9DMkUC8TkQVa/FhUMVIKi7TnjdPlRlfg7e34ZCW73
         jONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+T+zRU50EyoybWvV9puA2CX5+7utUDve2uCmkWDcVU=;
        b=Fkv91CnAjczGi8Gn2Q1g1Ha1QsQAScEXT90UPR739trDPgn/EDkHgDUE5TJa+0MAn0
         mfeyiPPNqFFsaMtmu5WbDXr+nWOk/HarNckoql9sMkV9CBOVGD6DEdmuPQq/5Zwea4/z
         h3kdsFCsiaTDp/BvMVs+nmhrrRxxr7oyqAq5Q07wqqrloHHDztPhyuMsMzEtBTC0bju2
         P/HzekmGOgDYPfxTyy1k1dUqRORG9aZgsLfhfFHSYEb3BFBt9BN3KMzXssr17Co55VHP
         5hK271QTvxkQyBMDjfQWTWIvHwVIubd0UAqMbSURGjkbcWdONdzeTKt/8l5jVVUmrePG
         IIZQ==
X-Gm-Message-State: ACrzQf2KHGETZAOsLPkmoAELkaIHfZHN8mdCEIWiLps3q8jWalemi8C5
        iCVQxk53pQ+HK6s0PkKiDFY=
X-Google-Smtp-Source: AMsMyM79Bzl/Axmwa1kFNk0sPDD6LGvI/Yhj+RoJh9H5Dh0Z4cCObAKCw+U7+fCVPO0/eZJ84pH/Lg==
X-Received: by 2002:a17:902:bf01:b0:188:571f:3756 with SMTP id bi1-20020a170902bf0100b00188571f3756mr8870909plb.171.1667586201548;
        Fri, 04 Nov 2022 11:23:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b0017a0668befasm73545plf.124.2022.11.04.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:23:20 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:23:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kunbo Zhang <absoler@smail.nju.edu.cn>, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] input: i8042 - fix a double-fetch vulnerability
 introduced by GCC
Message-ID: <Y2VYlc8RxOsKxbmm@google.com>
References: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
 <Y2TtXAW1LhOwlE64@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2TtXAW1LhOwlE64@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 04, 2022 at 11:45:48AM +0100, Greg KH wrote:
> On Fri, Nov 04, 2022 at 03:23:47PM +0800, Kunbo Zhang wrote:
> > As in the source code, the global variable is tested (at line 408) before three assignments of irq_bit, disable_bit and port_name.
> > However, as shown in the following disassembly of i8042_port_close(), 
> > the variable (0x0(%rip)) is fetched and tested three times for each 
> > assignment of irq_bit, disable_bit and port_name.
> 
> There should not be any problem with this as that value does not ever
> change except in rare cases (shutdown or init).

We use this chunk only to establish identity of the port, we do not
expect instances to change while driver operates, so I do not think
there is any concern with re-fetching/re-checking the port while it is
being closed.

Thanks.

-- 
Dmitry
