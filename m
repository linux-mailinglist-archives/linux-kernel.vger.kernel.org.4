Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F265CE66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjADIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjADIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:34:43 -0500
X-Greylist: delayed 1312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 00:34:37 PST
Received: from nc1.cschramm.eu (nc1.cschramm.eu [IPv6:2a03:4000:48:83:4479:b8ff:fef1:2c03])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC3F1869B;
        Wed,  4 Jan 2023 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cschramm.eu
        ; s=20160910; h=Subject:Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=bNlUUxPVx6r5E5AB++ov8MvDxQvaPuZGODNmmc20O6w=; b=iI1v8Iozw5C4W77ealjm5cLmhb
        YNiI0nBBJDW1HrseKXqdff5XLjCQiH3S+3B3N/PQhYf3UEWNou8v8RbiFWZyurBweHRcDxn9FzqlO
        i3D+LPqICNn9mVcd9eldw7rhVA5OezQuiKJ1bWqNHNkwqL+nR2g9gug/xnrYBIcUvWQA=;
Received: from [2001:a61:2448:6101:6731:8c4d:dcb5:31dd]
        by nc1.cschramm.eu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <debian@cschramm.eu>)
        id 1pCyt2-008dba-OJ; Wed, 04 Jan 2023 09:12:35 +0100
Message-ID: <b56a03b8-2a2a-f833-a5d2-cdc50a7ca2bb@cschramm.eu>
Date:   Wed, 4 Jan 2023 09:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     masahiroy@kernel.org, samuel@sholland.org, nathan@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu
References: <CAK7LNAQc-gEY_v-5f99r=Zeq0oQ3R7apdrc-3M14akhHBp_GoA@mail.gmail.com>
Content-Language: en-US
From:   Christopher Schramm <debian@cschramm.eu>
In-Reply-To: <CAK7LNAQc-gEY_v-5f99r=Zeq0oQ3R7apdrc-3M14akhHBp_GoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:a61:2448:6101:6731:8c4d:dcb5:31dd
X-SA-Exim-Mail-From: debian@cschramm.eu
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] kbuild: Fix running modpost with musl libc
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on nc1.cschramm.eu)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change seems to break expected symbol warnings when building an 
external module against a kernel prepared with modules_prepare.

The build used to show

     WARNING: Module.symvers is missing.
              Modules may not have dependencies or modversions.
              You may get many unresolved symbol warnings.

followed by those many unresolved symbol warnings.

6.2-rc2 still shows that warning but the unresolved symbol messages are 
now errors and the build fails (at scripts/Makefile.modpost:137). This 
seems to happen due to -T getting added.
