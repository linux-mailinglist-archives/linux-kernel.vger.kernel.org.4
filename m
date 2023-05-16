Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412A7055CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEPSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEPSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:17:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664726AB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:17:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ab2a37812so7583693b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261055; x=1686853055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVGlZG/MsCBdLJd2sTiRj1iau7qUMDFbzDbgKuSoeJk=;
        b=ZvUaPoW1tNREXA/x7esl2fAth6spH/jZRVs+3e57PARRioaHy133wPC/YhfTi0y9IS
         2/brY2FonnUA5mZkHLShr/c1Odj4FLb7j+40yhTB1NsPFl1mlmKdUOzfYretYrgK8lLg
         bbJ3sz1eXLk4NVgtLq59WVUAw9q8HBBGOsI0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261055; x=1686853055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVGlZG/MsCBdLJd2sTiRj1iau7qUMDFbzDbgKuSoeJk=;
        b=d4poV+es+zxQhFOVuhCIBouIw4+JbMYhyTbEABQib7XYlsDN3+DKS2vQeO1MaK608u
         5+gI+a2EhHCJR7XHpxbrushCsKznhK0GrTHXxDz+URGrQS6xgU35mCmNDtoyc57Dc8jR
         cJ9iHS5yPJm2JYwWk1orlIGRvh10eQiSQ1doG0Mqph9FzUqspr8A1zpY9W+tY/9OIx/T
         4dlvOEL8sCScu803rCIPMLhTXNAHQBJAusPsVSFsfLNSX3V5NLujaDEMvO8dTN8kdBJ0
         86XNquQ3VRK6brFuwSiu8AqgZS+27Uz9HRcLeiXQKTjUTPZzaWu4zz7fJjMOavEMrtwH
         AedA==
X-Gm-Message-State: AC+VfDz6nZCheX2DBqPoFbCuZ5ns+qmXv4c5rnW0X8JzDajV6K9sXkY4
        Gtf5euuJusgcfI8/uU4lvkwiqQ==
X-Google-Smtp-Source: ACHHUZ50ScF5EAXkcZGqiyKtShaHoMMUuBbnpLJjsP2+5r+0M7xt3KRRAGexoPIzyUdoh+x2t5QywA==
X-Received: by 2002:a05:6a21:99aa:b0:100:b7b5:ca34 with SMTP id ve42-20020a056a2199aa00b00100b7b5ca34mr35340311pzb.13.1684261055727;
        Tue, 16 May 2023 11:17:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090a3f1600b0024e11f31012sm11911pjc.5.2023.05.16.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:17:35 -0700 (PDT)
Date:   Tue, 16 May 2023 11:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla4xxx: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161117.F3FBC0C7@keescook>
References: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:53:55AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
