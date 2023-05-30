Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EE71717E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjE3XSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjE3XSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:18:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82473186
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso899831a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488669; x=1688080669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRZs/nBDDXW8hF6u2e1Wo2UXvn96rgveDiIWpS60WGY=;
        b=PEbjfLdxYEC5I+F/kOYnuFocUEL0W6zEKS+ZeM8Tp8kj+0TX4vs7zeOjMUUxpEMaUg
         2UkmXa1W8MWhwREV0tpYJAOUSqoNySdONFhTLeKsPtAGpm5i3p8qreXro7IMSJuKZ5Ao
         b5gNXVVDzX4e2emY9dZjDpPCK25JKyQlCcRuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488669; x=1688080669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRZs/nBDDXW8hF6u2e1Wo2UXvn96rgveDiIWpS60WGY=;
        b=K0TGGRgPQS2TfXuBe1g4s0Wg0gwEWAFtfdG/TY7LEh4aywTAy/yQRjw4OiwbhmeyB+
         XLIr3tKgA5iL3S++xIzTHhrLsU8+HxfLPB06MamAti+j2HR1ZnbPTBrd0ohIeIcU7tsP
         LWbkAHfMG725xiwUrLf2rOeQO6C7ouCelbcCYfXq4kwrex7+Y3ydPIFgXaN5Sbyd4v0w
         PY+VG1cKUW8eu+/tvSPsmA1PKKbSZs9cjvSD+XNq+UslUu7GPSaWrOWwW8yC/e4sQsG0
         aO4Xqi2oETZe/ssOpK2m5qn2+63l9WqRD2T57507cdOeczIksJHAVRboGz1CDsijAZok
         /xLw==
X-Gm-Message-State: AC+VfDxi6pBhjTHTZTAuxeikQms69OkQ0u6/aOceo9sl+O4EqzovGCo4
        K8NJX6yQjDzPBs+ZKIqR5pKDQQ==
X-Google-Smtp-Source: ACHHUZ6/bj4qVsM/B/G8XxPwHiN8FW4+MeCn8RZLVvQyrW0chzy85Wzd7JPVY1jU5UUXF9x7DFfebQ==
X-Received: by 2002:a17:903:244e:b0:1ae:5fb0:4256 with SMTP id l14-20020a170903244e00b001ae5fb04256mr4777826pls.57.1685488669724;
        Tue, 30 May 2023 16:17:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001aaf2e7b06csm10739048pls.132.2023.05.30.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:49 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: sym53c8xx: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301617.2D0EC7BCA9@keescook>
References: <20230530160323.412484-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530160323.412484-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:03:23PM +0000, Azeem Shaikh wrote:
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
