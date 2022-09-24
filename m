Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64925E8891
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIXFek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiIXFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:34:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F7E0DD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:34:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so1892584pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mz4Rd8XWjT7uEpyICKIeRorRz31JPqdwkS3WoVtgZ1E=;
        b=YAnoJQHThRucbW61ua/u6xNobwvjSMsDBhWmagFZ+jbbrBjAwyHJJyB9yeBIr+6Zy/
         ovycT5eSDOxv1lYHVmEGovIeFd7IOJFrk7sEGwNL9eQXPQAHd7IXayXmzOpmFR/tDDzV
         192WwYusYzo/demCP5XvZzv+K+L4jFJ3cNbzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mz4Rd8XWjT7uEpyICKIeRorRz31JPqdwkS3WoVtgZ1E=;
        b=diUKBEjSlJq0pou2Goe36mEIDc808egyHFZFo6m1Wd5lC84FxD0qkX9x/lhjj7T62j
         ywSxAbwKEAlP5G0JaUdq5lsrGDRjNBrSoOxxZAglYtHtGHRKkR0mtWM3fzd09/7bjUNg
         vF5dklVdXvUoZWt3ZND+0JcgRRmKGbb0srcF3kR16OkrHAhbfQQax6IeVwvhKFkUOKi/
         alRcApMdFAx2/IjfK0L3TyFxEBv9jZqRs706yw/eMXwdgcYhvW9po1DG7osG7cHh3amz
         v3vBB5mihFNYxuxAiPHq6V0C0qT3NN4OAw9iyqJuCd+wNAP45eAsmx5Gx7khjmCaKB2R
         RkXQ==
X-Gm-Message-State: ACrzQf2wjRbxg6VHpEnyyBC7bozsCX1ZaNQeuTqW1TBKp0BQ+yMkSdyr
        v3Yyuox8qgyFnBi2DJ9BhZ992w==
X-Google-Smtp-Source: AMsMyM6eKPkiP7tFNEPog0WIlIXL+zDxpnUgG9qnl3Zw/qL9B1ZDflmlKJ96AswT2LjX30R8TtwzBg==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr25574626pjb.167.1663997671985;
        Fri, 23 Sep 2022 22:34:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21-20020aa79515000000b00537e40747adsm7346146pfp.36.2022.09.23.22.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:34:31 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:34:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: hptiop: Replace one-element array with
 flexible-array member in struct hpt_iop_request_ioctl_command
Message-ID: <202209232233.0C4FB343@keescook>
References: <YyyUvuId7dAZadej@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyyUvuId7dAZadej@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:00:46PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct hpt_iop_request_ioctl_command.

I see no binary differences with the patch, so that's good! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
