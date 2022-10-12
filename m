Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D655FBF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJLC0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLCZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:25:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76495EDD3;
        Tue, 11 Oct 2022 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=39mSXGhcWwpKxPd727TgBHu3g3vMdVIiua+9TWSmZb4=; b=ISIwBfQqQpYsoYuTVkhYLja2sQ
        YzPHvRYChw31J6vsLrH/bB79/+eKmlQwk6qEpxt9Uq0TMktHUVjvJpcGJ0tUoGFewDGKZWB0oIDci
        wCasMHiN7WoxOSxasMfNkf/rj+cKOhVUVFT+sqB4F5ltGTLP9WRnFEcar9lsjHRCyhet5A0t+3Sc6
        bMpw7dnISoot5MuCIzJEeWbUjNRk2CXwWQgXE1FtcBw6jYO6NZeMsnk3/Vch9jXUYmzenkBfn8C/O
        tzctQpeQK9/HUuVI6oobHM82waYXS4mt4SNLhgSLl+9qm3VZ1zKwZ8h6s8s534tNRsNoBwFn0mO/t
        CHS8mJyA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiRRR-006Wzz-Py; Wed, 12 Oct 2022 02:25:53 +0000
Message-ID: <254fd34d-a234-7959-2bd2-bbc1ac45629f@infradead.org>
Date:   Tue, 11 Oct 2022 19:25:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221011190047.749145-1-corbet@lwn.net>
 <3c65451e-c9bf-55ea-02af-f375346c955a@gmail.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3c65451e-c9bf-55ea-02af-f375346c955a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/22 19:10, Bagas Sanjaya wrote:
> On 10/12/22 02:00, Jonathan Corbet wrote:
>> For a long time we have rejoiced that our HTML output from Sphinx is far
>> better than what we got from the old DocBook toolchain.  But it still
>> leaves a lot to be desired; the following is an attempt to improve the
>> situation somewhat.
>>
>> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
>> adoption of Sphinx, we have been using the "Read The Docs" theme — a choice
>> made in a bit of a hurry to have *something* while figuring out the rest.
>> RTD is OK, but it is not hugely attractive, requires the installation of an
>> extra package, and does not observe all of the Sphinx configuration
>> parameters.  Among other things, that makes it hard to put reasonable
>> contents into the left column in the HTML output.
>>
>> The Alabaster theme is the default for Sphinx installations, and is bundled
>> with Sphinx itself.  It has (IMO) nicer output and gives us the control
>> that we need.
>>
>> So: switch to Alabaster.  Additional patches adjust the documentation and
>> remove the RTD references from scripts/sphinx-pre-install.
>>
>> The penultimate patch changes the way that kerneldoc declarations are
>> rendered to (IMO) improve readability.  That requires some changes to
>> kernel-doc to output a new container block and some CSS tweaks to improve
>> things overall.
>>
>> It should be noted that I have a long history of inflicting ugly web
>> designs on the net; this work is a start, but I think we could do far
>> better yet.  It would be great if somebody who actually enjoys working with
>> CSS and such would help to improve what we have.
>>
>> As before, I've put a copy of the rendered docs at:
>>
>>   https://static.lwn.net/kerneldoc/
>>
>> To compare the kerneldoc changes specifically, pick a page that includes a
>> lot of definitions; for example:
>>
>>   https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
>>   vs.
>>   https://www.kernel.org/doc/html/latest/driver-api/media/drivers/frontends.html
>>
>> -------
>> Changes from the initial version:
>>
>> - Tweak more alabaster style parameters, including the maximum page width.
>>   There will surely be disagreement over what the right value should be,
>>   but at least it's defined in units independent of screen resolution.
>>
>> - Remove "classic" theme configuration and a bunch of other conf.py cruft.
>>
>> - I've tried to answer all of the other comments, but a couple remain.  The
>>   sidebar contents are unchanged; making that more useful will require some
>>   thought and work.  The gray background on function prototypes that Jani
>>   pointed out is actually something I did intentionally, with the idea of
>>   making each declaration stand out better in the wall of text.  I still
>>   think it's better but am not married to it if the world disagrees.
>>
>> - I've tested PDF and epub builds (no changes) and Sphinx back to v1.7.
>>
>> In the absence of objections I'll be putting this into docs-next after the
>> merge window closes.  We can (and surely will) tweak this forever, but at
>> least it, I hope, shows a direction in which we can go.
>>
> 
> Hmm, I can't cleanly apply this patch series on top of either Linus's tree
> or linux-next due to conflicts on [1/6]. On what commit this series is based
> on?

Normally Jon uses this (from the MAINTAINERS file):

DOCUMENTATION
M:	Jonathan Corbet <corbet@lwn.net>
L:	linux-doc@vger.kernel.org
S:	Maintained
P:	Documentation/doc-guide/maintainer-profile.rst
T:	git git://git.lwn.net/linux.git docs-next


Did you try that one?

-- 
~Randy
