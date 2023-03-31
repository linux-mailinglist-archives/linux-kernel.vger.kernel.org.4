Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AAD6D1AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCaI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCaI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:58:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA61D932;
        Fri, 31 Mar 2023 01:57:45 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1piAZm-0000VF-2g; Fri, 31 Mar 2023 10:57:38 +0200
Message-ID: <c2d5cc07-ec95-eb64-0cef-42f8378ea054@leemhuis.info>
Date:   Fri, 31 Mar 2023 10:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US, de-DE
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 4/4] checkpatch: check for misuse of the link tags
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1680253065;82b905b8;
X-HE-SMSGID: 1piAZm-0000VF-2g
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 20:13, Matthieu Baerts wrote:
> "Link:" and "Closes:" tags have to be used with public URLs.
> 
> It is difficult to make sure the link is public but at least we can
> verify the tag is followed by 'http(s):'.
> 
> With that, we avoid such a tag that is not allowed [1]:
> 
>   Closes: <number>
> 
> Link: https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/ [1]
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> [...]
> +# Check for misuse of the link tags
> +		if ($in_commit_log &&
> +		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
> +			my $tag = $1;
> +			my $value = $2;
> +			if ($tag =~ /^$link_tags_search$/ && $value !~ /^https?:/) {
> +				WARN("COMMIT_LOG_WRONG_LINK",
> +				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
> +			}
> +		}
> +

I must be missing something here, but it looks to me like this is
checked twice now. See this line in patch2 (which is changed there, but
the check itself remains):

> } elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {

Ciao, Thorsten
