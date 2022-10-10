Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82215F98E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJJHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJJHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:02:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5BF3B713;
        Mon, 10 Oct 2022 00:02:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B193F1480;
        Mon, 10 Oct 2022 00:02:37 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F0E03F766;
        Mon, 10 Oct 2022 00:02:30 -0700 (PDT)
Message-ID: <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
Date:   Mon, 10 Oct 2022 08:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org> <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
 <Y0AfK7sVphNkQA4q@kernel.org>
Content-Language: en-US
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y0AfK7sVphNkQA4q@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/22 13:44, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
>> On 10/6/22 13:58, Leo Yan wrote:
>>> On Thu, Oct 06, 2022 at 08:45:18AM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Oct 06, 2022 at 08:26:00AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Also had to remove:
> 
>>>> 		$(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> 
>>>> from this patch, as it makes install fail at this point in the patchset:
> 
>>> Thanks a lot!
> 
>>> James and me had found the merging conflict and planned to send out
>>> email for reminding it, the right change for above section would be:
> 
>>> @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
>>>                   $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>>                   $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>>                   $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>> -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
>>> +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
>>> +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
>>> +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> 
>>> It's deliberately to not add '-m 644' when install coresight test
>>> shell scripts under the folder tests/shell/coresight/ so that we can
>>> keep the executable permission for these scripts.  On the other
>>> flip, we set 644 mode for the scripts under tests/shell/lib/ so
>>> these scripts will not be executed directly by perf test framework.
> 
>>> @Carsten, if have chance could you confirm for above change?
> 
>>>>     DESCEND plugins
>>>>     GEN     /tmp/build/perf/python/perf.so
>>>>     INSTALL trace_plugins
>>>>     INSTALL binaries
>>>>     INSTALL tests
>>>> install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
>>>> make[2]: *** [Makefile.perf:1007: install-tests] Error 1
>>>> make[2]: *** Waiting for unfinished jobs....
> 
>>>> I'll add it back when the first .sh gets added to tests/shell/coresight/
> 
>>> Sorry for introducing extra efforts for you and thanks!
>   
>> oh sorry - indeed i didn't see this problem coming after fixing the
>> conflicts. i've got an update of the patches that fix that. should i just
>> send through the 2 updates patches as a v10 or the whole series?
> 
> No need, I did some fixes taking into account the comments on this
> thread, we can go on and fix things from what I have now at
> acme/perf/core, which I'll send to Linus today.

oh cool. i'll let patches sit for now - let me know if there's anything 
you want/need from me.

