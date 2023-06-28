Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7E7419ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF1Uw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjF1Uwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:52:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F381FC2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:52:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668709767b1so163978b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985569; x=1690577569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzojRQ1F0egJqRD59S+FcTqPfQzuWDtOgop6JLdMSGw=;
        b=HiZCgsxp983FQwUw2sx6AdlekN/G/snxYdNfXGidR0MDb7jLkQBBFNFwLrGSrQ8Glp
         fERHuElJlAG+HKiB7tDmZFk/hlwsXHeyhKiUZZa+VaBQhdTP1LUiOQJN4XErfGNoIihl
         oMBaNPGR0mKrDczhcQ9qXSMBEhdHf7Gy6/UQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985569; x=1690577569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzojRQ1F0egJqRD59S+FcTqPfQzuWDtOgop6JLdMSGw=;
        b=Y1W4wtfIOPpmUjK955BchaLYRcSmBpbLy08rsUE/n6bMfEjsLktfsWEdHCz2A8Cl1Z
         /dDT7M8EcCJdrMfbzQ0QZqGoWck7bjdRStJX7+xnyRfe8bUUa5j6VJpr0lwp9HRAodym
         SmEOs9wKId2w8ov9OXKIpX/71ZspHh6qeZpJhA+Hvpwt3swSzzhyZSv8zhbIyf6PgHsZ
         AbY5OPzLpPaMlaUn20mhlQ/r2cas1WhsjRkShkzKmZr7u2xRplE+RWfceIf3VwJL38RZ
         9Fw+aGf0zyaFzraFf3LiN9O7AaYBl3p85FeSurU66GBj3w3gsaZSKLnG/9KGbDDti2hJ
         QX4w==
X-Gm-Message-State: AC+VfDxVvFic5/DkoWPO2M6TXHZRJg/Roje8uJQNmr0HJNGsTJOUwuLY
        cGIJIbET0RN3eBIX7mE+1R/Fag==
X-Google-Smtp-Source: ACHHUZ6aWKbpdlWdbqo0UZTOBgabSUelUcGn6RoJQGsfCDv2XWMn23NkmZOmuIik8ez8Eq2+BIMQaA==
X-Received: by 2002:a05:6a00:2341:b0:680:98c:c58d with SMTP id j1-20020a056a00234100b00680098cc58dmr4879003pfj.2.1687985568796;
        Wed, 28 Jun 2023 13:52:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0064378c52398sm7355134pfn.25.2023.06.28.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:52:48 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:52:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 06/10][next] scsi: aacraid: Use struct_size() helper in
 code related to struct sgmapraw
Message-ID: <202306281352.815ED6569@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:31AM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.

Oh, I think you can add two more patches to convert sgmap and sgmap64
fibsize calculations too.

-- 
Kees Cook
