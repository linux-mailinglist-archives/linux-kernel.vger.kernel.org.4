Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCB72C383
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFLLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjFLLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:53:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C32978
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:52:10 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 627671EC0398;
        Mon, 12 Jun 2023 13:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686570729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iZhYZTS/exJyQzB19qwAl5pWglF7rQ+U0ac4FoA1V0o=;
        b=XVcrfz6BPJmjxxeE7zmvLg7fVp+QfuQsOAa5JHKaDnyA0RqaO9ii5XxE6XXN0wWBxBLRV5
        OcJ/jO5yUNji7n3K8am2Pj/5L5fOjUm9Zlw1KlGBXS9pbgm0EQLlXWtARM17T7HG2eJ+c/
        Gg3KZp/2bcrVXWa+aX7qxGGtpcedgho=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686570728; bh=iZhYZTS/exJyQzB19qwAl5pWglF7rQ+U0ac4FoA1V0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgVEB7LG4HuBaQtF6S4ZM7/wNFWh7MfVuzwLB8AHvvBWUUMq3MhKSPcZTSt+RxSFX
         k8+W9ooRa3zFjFQcHcsqqxkSO+Ru4U+AQ5qtLzFHQeXuK7/oKJ72aajFf+pA2MHiA1
         lmPqj88NU8d8QVLRxT5pVUcVVQKvsck201/rUlWqofSAP8oqGQ7nzXf7gQDMssPQh3
         JFgBSgGxuxyvP6AvC7cNANx95QdqXgxB8qCjXW+AJ+i0fheozRNft5j8f3xPq1sQJR
         aZuIdqRmKsvlvxJiI8e68dDicFT+TXwWTWk2P/IH/OaSeF1BgVjX2o1tIVr7ZkCL8e
         V+FLFDd4p9uhXjfmxj6r+R2IzpqMni/0U8UUkv2xlnS9fuuTXHq5D/njtyp0HSCG+9
         ySxNAn/xgXyPzy4YilSWA43jE+fkWc6avS63iW2VqJyNDZ4PXz33zCX3DV86GGk9sb
         U9QTMSvjxsO2H4uTIC3IX6ohpFw1DCwI6U29VAIWAA3an69Rbvfj2ZdSBCt06jZoCG
         vsxORkKaJxQen+w7/CBRfRnxaJ0DJa2rHGCYp+1O8MCd2jCZKaszG/7LH82bInyG50
         bPBQ6oGHx1/mKtmEXo8IJIRHhYf4xQSy2poAqEYOYD87CBoXfa5VZEn7XLQwe4Y9Gr
         LBR6xZtonGtrk8xVNyiYdO/A=
X-Virus-Scanned: Debian amavisd-new at mail.maysoba.com
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.maysoba.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9u111MmGTE7Z; Mon, 12 Jun 2023 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686570727; bh=iZhYZTS/exJyQzB19qwAl5pWglF7rQ+U0ac4FoA1V0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVrPaWdDHVI0pof13JevT+8ZOsYsSiFPpx9knYCK3CUYE4P1ZtMMoAjqnhvgWooN6
         9FRyeF7inJOJbDZCp0cFV9j2qMYxZshnaym7MCLvYbpKlB/qz1tMDSfZlwCvY9lenJ
         31k9zRMy3PlRTccDJjATwnVV3zxxgsZVjaSUlmq1UK+he86BsDGOyBbzIyuCU4qEja
         6C9b/2isL4sMaRBtgW0daAid/jOXWrEk+Uj29v/dnNKCAv0lS1Ia2nn1bpV0WzGpHP
         YNx4sZtDKnGe0bNG4eA1jzwSEuBmnK/Iiuh37fOXmsl2B0GPs1+rlJYdm7vOOhr624
         L3/myjSnPf0F+SF9Gk8Hici91stppDUSgBqKX27EhbTXxkZY+m5dpDHUZvSwSzfC9h
         C/09TK532kvAyCatFkzz3xZss3xHK+4lPCipuE4wacAbLKurccpRAu+Lo6fsQrKRJN
         X9QZvgnm1xCngrV1VRoJ7KwhC78lC+Vdjc8xTCdRhae5ClF7VS/aK3qtjHs1NM5zDV
         HbphiBvevJZ4hPn2JooRB/KKnqvb70GlI68uuzGR5WZaJIFcC/jbVS5GEtOTWHxqsl
         M+++8pu2nvJ5/t1EclwcpI1UCJSsOdAbPAJCEFUIHTO9avkWy8N/vZ0Lz3JLBpEpp7
         dRDdfwjlZRDdIU0wZy89PxPU=
Received: from zn.tnic (p200300Ea971Dc508329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c508:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19EDE40E018C;
        Mon, 12 Jun 2023 11:51:59 +0000 (UTC)
Date:   Mon, 12 Jun 2023 13:51:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Laight <David.Laight@aculab.com>
Cc:     Breno Leitao <leitao@debian.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "leit@meta.com" <leit@meta.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612115154.GEZIcG2tWkn8I0+E2t@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
 <543116e1a8cf4b7a8b086c850374f99e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <543116e1a8cf4b7a8b086c850374f99e@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:22:15AM +0000, David Laight wrote:
> I can definitely justify compiling them all out.
> For instance embedded systems with limited userspace and
> (pretty much) everything running as root.

Nothing's stopping you from adding "mitigations=off" to your grub
config.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
