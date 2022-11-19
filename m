Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC76630CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiKSHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiKSHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:09:29 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9D950CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 23:09:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p21so6418178plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 23:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ACiJTbXNJeqE/gxlmjEP49H2c4SghNGRkjD+ba2fsY=;
        b=X+H4O1YxrB7WboZ+TpnIVWrX5yqtIjQX5Bgu41ubRJotRsZa2e7rzFXUbtMnVyP8MK
         a6uxX4rQy+sJFGMuKW5X+d6EP1MKXJC0k3ccQfFy1HnD5zkD0jKI53LZSk4pI/lqE5sZ
         tVwDkAiDVtodv4Riox1/pue3VHY5ZA+WN4N8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ACiJTbXNJeqE/gxlmjEP49H2c4SghNGRkjD+ba2fsY=;
        b=JE2jXkO1CnQvQ0a+K1Y02bhh5ZtU2q8OjnIVzmhibop1yp+HiJhanwSYpJgdtzBsrx
         r0piOSyMK0cbRNVMYLz5vahkXyG1uiJBx99OAXrHJ7mRgeC8DZZeOoF+fG93cGT8bdqr
         6b3JO5GlgowhP8MiXVhhZO4v/xLqsDOY7WKUawmMj6qy9ihHMPr/SkBOcDSKjOUmi8sg
         qB6ogY43Jqc7UE09BpwbYkPeIHao8yjbT8eqKHjypcO005l8Rfl4l/ypfiWVawlYieCm
         ttVIyQ8D4yfKDej8uO+35VbAl8vJj6N3ncSu58M6m/dHU9f+weryvArXwzTePO6QE9zK
         OvIg==
X-Gm-Message-State: ANoB5pkZDUbr2cgp2/qGPRguVcpnx3AY4bQ2Q50fGxbFphnopD2n5+M8
        snRgv6sv4LAJmouJP+Fa9K1PkQ==
X-Google-Smtp-Source: AA0mqf5zwvmnUs0B49pK5yJ7yPu5BHkdCfLczJZ3lPalcKIdye1gPv2FogDayRYZhRw0bf6P1zAnQQ==
X-Received: by 2002:a17:902:70c9:b0:176:a0cc:5eff with SMTP id l9-20020a17090270c900b00176a0cc5effmr2887849plt.128.1668841768770;
        Fri, 18 Nov 2022 23:09:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a4b0900b001efa9e83927sm6455386pjh.51.2022.11.18.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 23:09:28 -0800 (PST)
Date:   Fri, 18 Nov 2022 23:09:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: qla2xxx: Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202211182309.E0127C6A0@keescook>
References: <cover.1668814746.git.gustavoars@kernel.org>
 <faa40e6b31ecc9387ad1644bb1957aa53d7c682f.1668814746.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa40e6b31ecc9387ad1644bb1957aa53d7c682f.1668814746.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:47:13PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays as fake flex arrays are deprecated and we are moving
> towards adopting C99 flexible-array members, instead. So, replace
> one-element array declaration in struct ct_sns_gpnft_rsp, which is
> ultimately being used inside a union:
> 
> drivers/scsi/qla2xxx/qla_def.h:
> 3240 struct ct_sns_gpnft_pkt {
> 3241         union {
> 3242                 struct ct_sns_req req;
> 3243                 struct ct_sns_gpnft_rsp rsp;
> 3244         } p;
> 3245 };
> 
> Important to mention is that doing a build before/after this patch results
> in no binary differences.
> 
> This help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/245
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
