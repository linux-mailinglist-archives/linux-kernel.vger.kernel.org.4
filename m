Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1606A61FD9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiKGSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKGSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:33:12 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CD1A046;
        Mon,  7 Nov 2022 10:33:12 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h193so11177411pgc.10;
        Mon, 07 Nov 2022 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J294Ls2PuK2M+yjQKqmFkVhSVTVzr2jnzbgHYThDr8E=;
        b=Qrsmr9H/iZyFWEJzoRas3txJmxwklHh6LHsgIY5JZyGXeHAyDG6IryLrZRJ+7mSej8
         1JW9M6NPKg+RBR30JmTBvUh0IoHfztYJFet3KDNvSmwgfdqr7p1UTi7bXzOsOC7dF/GP
         FjjNsiyONg4D/QPhd2z4/BrLkUNPOxzcTwMOZ88TSry4g7QO0D2QnMhBits42Lsf5pVG
         MTadpUTmwraORVc7uVprNth+qdv27b/wB/Ad69WJebEg0r8GzQQq/+msQA7SuOpe2Abr
         RqsfLCqtcN+Q6fJdY7dF6qnD2xGZx4FnijCBxzH9pMI4IZU7S8JugmaxRrk8SDNbS6WJ
         Rz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J294Ls2PuK2M+yjQKqmFkVhSVTVzr2jnzbgHYThDr8E=;
        b=IIGa/vP4YPZZTWDgePb6dR8YIoKiUVAKno7Qhpcru0SCbWp8J9aEemoaNLRVlnzROT
         haSfZX3cFNtx90jHU1B1GKOsWBOtsM+jiCC6ikyS/R8YCu7dJIGJXO+86WCMtxC+i3H3
         PaXDzp8zkKChP3bxdCIOTDb108i17UwhT5O3EXzx+fHs4iEeNhtSPefTt0WqACtNFs4x
         aVFZ08vXOiuGhwAAx5DJB8nWxyJCAgqHntRj62TDv8M7dXfop27d67OJJ+aLmbGIwnAS
         tMqHlK3ub0r+XPFYfqhl1G/Cdc9hNt7QSfBkq6vofMFUHk1EqZ8Sss3qOsH+c5AZuJhs
         4sKw==
X-Gm-Message-State: ANoB5pmJ1PJRhqIhStNWSROSARC4gsw666AQK7XGjxVNMsyAsyo1yHYf
        0jssm5Uu+7AkNIoYAcRNVmI=
X-Google-Smtp-Source: AA0mqf6adboau7bkwFsUZwC/dpqHC/V7SDtypCTTX4GvA14bFUm0cBdL/A9c2e+dAYX9y/8tJACVYA==
X-Received: by 2002:a63:f94d:0:b0:470:5d17:100c with SMTP id q13-20020a63f94d000000b004705d17100cmr10400023pgk.615.1667845991353;
        Mon, 07 Nov 2022 10:33:11 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001866049ddb1sm5337312plk.161.2022.11.07.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:33:10 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:33:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        u.kleine-koenig@pengutronix.de, dvhart@infradead.org,
        andy@infradead.org, lenb@kernel.org, arnd@arndb.de,
        peterhuewe@gmx.de, kys@microsoft.com, kronos.it@gmail.com,
        bleung@chromium.org, sujith.thomas@intel.com, vithampi@vmware.com,
        lee@kernel.org, wim@linux-watchdog.org, jgross@suse.com,
        davem@davemloft.net, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] acpi: make remove callback of acpi driver void
Message-ID: <Y2lPY/pcWzEzFzwY@google.com>
References: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 10:57:53PM +0800, Dawei Li wrote:
>  drivers/input/misc/atlas_btns.c               |  4 +---

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through whatever tree is best suited.

Thanks.

-- 
Dmitry
