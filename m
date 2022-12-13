Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63A64BD94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiLMTua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiLMTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:50:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85AAB2656F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:50:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B9D2F4;
        Tue, 13 Dec 2022 11:50:57 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF80B3F73B;
        Tue, 13 Dec 2022 11:50:15 -0800 (PST)
Message-ID: <3a11ed33-0a3d-2668-ab2b-c44eea7eddbe@arm.com>
Date:   Tue, 13 Dec 2022 19:50:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a trace
 event field that is a cpumask_t
Content-Language: en-US
From:   Douglas Raillard <douglas.raillard@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20221124145019.782980678@goodmis.org>
 <20221124145045.743308431@goodmis.org>
 <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
 <20221212111256.3cf68f3e@gandalf.local.home>
 <8448372a-6911-e920-b630-15af850adcae@arm.com>
 <20221212185330.639bf491@gandalf.local.home>
 <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
In-Reply-To: <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-2022 14:20, Douglas Raillard wrote:
>
> The only case I can think of where parsing would not follow regular C abstract declaration syntax is a type like that:
> 
>      __data_loc int [3][]

After some experimentation, I came to the conclusion that "__data_loc <type> [] <id>" can indeed support any C type if they
need to be added in the future. I would heavily suggest that any future extension works as the following, to avoid messing up
the grammar in a subtle way that would prevent some types to be expressible, or make it a nightmare to implement.

The recipe to parse that with stock C parser is:
* consume "__data_loc"
* parse "<type> []" as a func prototype parameter declaration
  (declaration using an abstract declarator, i.e. not introducing any identifier)
* parse "<id>" as an identifier.

> The outer-most array is by definition the dynamic one, so "[]". In normal C, [3] and [] would be swapped as
> the outer-most array comes first. That's not too bad though as it is not ambiguous and easy to fixup directly
> in the parse tree.

Simply swapping is wrong in the general case. The correct modification of the "<type> []" parse tree is doing a
"barrel shift" on nested array sizes. If the type is "int [1][2][]", it needs to be turned into "int [][1][2]".
The now-top-level sizeless array is the dynamic array. Note that pointers level are transparent,
so "int (*[1])[2][]" needs to be turned into "int (*[])[1][2]"

-- Douglas



