Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBA727727
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjFHGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjFHGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:16:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A14B1BC6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:16:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B18871FDE2;
        Thu,  8 Jun 2023 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686204987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SaX6NtKYZMTim32HIHOrx8xVzXx77vvLis1U96tRWQ=;
        b=GWSiC+kOOu9YB8l2UD6QTaP5K/JXTrGgnlhGP99yTXFt4/YDk0MkG6IcaEV1OlKx2fwKGj
        F7fyUmxHeOTG3vTjtSBnAwzeaXNQOL6Fkn6LDkREKuObuePU9lmelb98tmfsRphnPsKcq6
        4kMOLzgR7bn19n1HKQlCXamHbzBb9i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686204987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SaX6NtKYZMTim32HIHOrx8xVzXx77vvLis1U96tRWQ=;
        b=q+jF671Hyq5DguVVm+Sl2HgtqChWjkmCG5Gd2stjJ/zr8L92NcTypQcf8rN/4RRj4Os2s2
        gHcMNTAjamjOU2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C26713480;
        Thu,  8 Jun 2023 06:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQ8TITtygWQ3GQAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 08 Jun 2023 06:16:27 +0000
Message-ID: <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
Date:   Thu, 8 Jun 2023 08:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
Content-Language: en-US
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <871qimkdft.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 23, 2:25, Thomas Gleixner wrote:
> I really wish that we could disable syscall32 reliably on AMD and make
> it raise #UD as it does on Intal.

Sorry, I am likely missing something, but why is not #GP enough when we 
set CSTAR = 0? It's of course not as good as Intel's *defined* #UD, but 
why is not the above sufficient/reliable?

thanks,
-- 
js
suse labs

