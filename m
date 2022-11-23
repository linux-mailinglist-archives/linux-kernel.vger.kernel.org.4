Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6C6363B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiKWPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiKWPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:30:04 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE66C4B5F;
        Wed, 23 Nov 2022 07:29:08 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5CB5C921989;
        Wed, 23 Nov 2022 15:29:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 62A109215A8;
        Wed, 23 Nov 2022 15:29:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669217344; a=rsa-sha256;
        cv=none;
        b=6TW77D8Ar+SeO6vesgbCSPdzBQ7D2R0FKH7bxJXtSZY5R8jjk6rJ7HMXoBvo6p2gS6mENq
        bte6P37T0JeFR9kNmEOFTfmciHaCYw8J6k3uziatZRwbAR8Fv8rrIPok6Ag3NITqXGfKTW
        0kLJ57oJ3ei8Sp1nUYVz2y9SWpJ2Vs7qLm0rDsdTCSiE3ZCANpygMSMGHQ02epRiqoqkld
        FhR3AsWdLrE8bcBywDeug8GO404oURXCQxsxel6QoXqvPIu9dG4+TM1yBEpBZyBAmxd+g+
        k2ljlb/HreNiANr/l4D1bwFOojjcazrK0SURo7alKsVPS8zo8tnPPFWQ+xveLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669217344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=sGvRTBGDTkBsnA1+bVPHCS1GTnaqg1DEaasrICdNkt0=;
        b=loHbejB12ouufdZUXF2Giv3hJ3OrQs1PdWmi4OehcWQ7iJ/9STJAl5gUAmnLWwHL0yqyko
        w3C24fi3NbdcZe1bqXsLiK7yCQ8veZmv5HnJM0nlIB6IGyeB2kU1Xdq3tx8+NM+3eybXqA
        gT1E4p0ESs707HYdX+/aRkywowC2LQFN138OadJc9cQSq+G4hjltm3eA+mO8xzmdEGfiDe
        zStMarlMErsK9hD/Hys9/HVp4vCKRTF3bctZLYt8UKPqozgX565HN70JMfpiPQYZeBDDvk
        Tq6Buv7kTExYN53e+tjugLSMG1Ls/tcY0dOQkaSeYhGN0W0I2rIJDYvkNMWdcQ==
ARC-Authentication-Results: i=1;
        rspamd-64c57ffbcf-j2d44;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Decisive: 01c853c271ab01f2_1669217344831_2421916507
X-MC-Loop-Signature: 1669217344831:2788001007
X-MC-Ingress-Time: 1669217344831
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.81 (trex/6.7.1);
        Wed, 23 Nov 2022 15:29:04 +0000
Received: from [192.168.0.182] (bras-base-toroon4834w-grc-23-76-68-24-147.dsl.bell.ca [76.68.24.147])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4NHQ5V3qF0z81;
        Wed, 23 Nov 2022 07:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1669217344;
        bh=sGvRTBGDTkBsnA1+bVPHCS1GTnaqg1DEaasrICdNkt0=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=QExHXNZfe/T1hLFwa3wUEl72oNFOLGLjJc4j7xnnMWQha9tS9ihTYizhmrx6aS8cr
         SvDcTY0G4BaELr+hzwYmoN1xIMiddgy34AKUAZBm7/+1Yo1QsoM3Pj0zReZa1Qg87Z
         xTENwZNzUpM0Jmg0k+ain/kzruGmW48HzaP8DSnc/u3NV0z1Kdhf6lbjlAy6fByLsf
         dc4pfQeyxdfnMjKntvrxrKzlRnHnEu4L941coBob1o3Fy16pDL1ffCH2LznufL07z1
         bf3NzggJKtGjyre854J00wpEkOc9yLKkVGiKhiRjO4NTneChOmB7SUNWbh+zrDjnW2
         Os6cRHArEzWrQ==
Message-ID: <706f23a9-8798-b8b3-2934-c4b56ab34058@gotplt.org>
Date:   Wed, 23 Nov 2022 10:29:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
 <0da67f73-dd73-7e6d-74c2-14aec5d79902@gotplt.org>
 <202211222113.10003CF8FD@keescook>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <202211222113.10003CF8FD@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-23 00:15, Kees Cook wrote:
> Yeah, it depended on a bunch of various clean-ups, which have finally
> managed to land. It's late enough in the devel cycle that I suspect I
> will hold this one back until after the merge window and then make sure
> it has plenty of time to bake in -next. If the rest of the patches
> continue to behave, I may change my mind... :)

OK, thanks for responding!

Sid
