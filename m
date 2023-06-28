Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273597419E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjF1Uva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjF1UvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:51:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED351FEF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b5f362f4beso90314a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985480; x=1690577480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP0bXSs2vVbWc7nKFI6QoxCUJ3C1YWOqkj+wTitBDqc=;
        b=Lo2CcrCL9oe8kvhQVqlQS5R+0S7iqR0SsmjOLDWpnDgGi9bm8RKsBzZrOb43c7DA7O
         nxbYkYcJgcZEPxP7sn7Crs5BiYti1hQz+prQ7O/08hw7IXMXrHQ2Hua7jebKEe0fN9Hf
         AtkKlUbxX7bSFjCkyoiVHnmD7EDgVc5dYL0O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985480; x=1690577480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP0bXSs2vVbWc7nKFI6QoxCUJ3C1YWOqkj+wTitBDqc=;
        b=id2PfBSI2WIsMA/euYWK0ibezXC0QXiTPgRt58Gs4vpes4dexM/Zg1FjKb06TDQO76
         WG+ulkc5UUVOLHgi6ir9HoJJkQj3T60FymEC+oYmtq2ruz6QU1XXfw5aJQ0QO+/edCg0
         I2KBYChzJsykU2YeW4HN2DV8I4cRjWbGjTsn/QXtad1E5JLmupxx0FphwLJ4g39GRlje
         P1f+iOMb5LTphTmd+iWP5Gswe7fI3zYPW8fd56ZQvIuomilpd0GQgIrj3kyi/sinzMXd
         qBb3G1DZPktDp7Ggo4hERobnr4vAPJxeUzcUfJ0yW6MZy7diC4H6afDcOpUBBqHndx2n
         FGBg==
X-Gm-Message-State: AC+VfDyc8wcQXjhBWJdwFZ23MIcsB1lVIIM+ma7CwTzHuLECzt81zn5Y
        7PERg/ioOHbSHzoM1HR6T9shHw==
X-Google-Smtp-Source: ACHHUZ6jhyLKKeHPuPtSXt8ApEyv98ChgMOnNAtkcK9QOfalGkyJAcNmZpDpNOlEntpRLln4pnhyLA==
X-Received: by 2002:a05:6830:613:b0:6b8:19d8:6925 with SMTP id w19-20020a056830061300b006b819d86925mr7542358oti.12.1687985480265;
        Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a019500b00256b67208b1sm10669705pjc.56.2023.06.28.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:51:19 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:51:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 06/10][next] scsi: aacraid: Use struct_size() helper in
 code related to struct sgmapraw
Message-ID: <202306281351.6572899FE@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:31AM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
