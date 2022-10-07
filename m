Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED75F7434
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJGG3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGG26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:28:58 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611253AB2E;
        Thu,  6 Oct 2022 23:28:56 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bk15so5724159wrb.13;
        Thu, 06 Oct 2022 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u2Ot0Wg6ar9WnrWkkALRT16dJHwvyKZvHYt+Q1mssI=;
        b=HGVvcC4znxAhKXaME0J8zuN+ju/pcw6sOhFdIlo/VINkTUAwZ+BUn+AH2MED9Ku8AM
         DQKMLz9iQV1ITGFCWXK6RfPupt8bO1VgrN3nc3++lFd3iknZ3DlTsF/3/soHhbHTmvW/
         c+6+KMsVbxGnj7Eng9TzGnDeZMhtJiyMYJGg0gH086VAewirZmTpPsVjhnLU0frlHlzT
         tZsz4NZ/Nb22jh+Ni08OVKjFEg1DinwqUrHJ8F/sYrss7klAaT6ohi+5fdYQH+SkyiJm
         mBx2RsStWXJxjeuAKtY8WkcZXGsIxdH4927ecRgwX+ET0ER1oG1aAfecHdYdBv5ppUrT
         yQRA==
X-Gm-Message-State: ACrzQf33rC/X3pRLrXtGUFvPFMw1NnZqc2eBk8EpXfqWWCDzxiABYk3I
        OH2IvTUmx/BT88VpmqK+mBwvyUQjYr9WIQ==
X-Google-Smtp-Source: AMsMyM6d6OJ+MLqPRmMwqRObmvb3fN70n/+Amxl69MgZYPDScp36W9VgcjSWk4znacGZ8ftAW/umOg==
X-Received: by 2002:a05:6000:184e:b0:22e:4612:496d with SMTP id c14-20020a056000184e00b0022e4612496dmr2110667wri.91.1665124134754;
        Thu, 06 Oct 2022 23:28:54 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c0a0c00b003b497138093sm1299420wmp.47.2022.10.06.23.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 23:28:54 -0700 (PDT)
Message-ID: <c009eba6-3b49-c869-d6b4-267f1547d358@kernel.org>
Date:   Fri, 7 Oct 2022 08:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org> <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan> <Yz7klV3h+JJ+ilAp@kernel.org>
 <Yz7vJ9Wy0zCTwp1t@leoy-yangtze.lan> <Yz8Ma75+RgGVYqBN@kernel.org>
 <Yz8TojIibofTn8Rp@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Yz8TojIibofTn8Rp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 10. 22, 19:42, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 06, 2022 at 02:12:11PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Oct 06, 2022 at 11:07:19PM +0800, Leo Yan escreveu:
>>> On Thu, Oct 06, 2022 at 11:22:13AM -0300, Arnaldo Carvalho de Melo wrote:
>>>
>>> [...]
>>>
>>>>> @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
>>>>>                  $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>>>>                  $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>>>>                  $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>>>> -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
>>>>> +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>>>> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
>>>>> +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
>>>>> +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
>>>>>
>>>>> It's deliberately to not add '-m 644' when install coresight test
>>>>> shell scripts under the folder tests/shell/coresight/ so that we can
>>>>> keep the executable permission for these scripts.  On the other flip,
>>>>> we set 644 mode for the scripts under tests/shell/lib/ so these
>>>>> scripts will not be executed directly by perf test framework.
>>>>>
>>>>> @Carsten, if have chance could you confirm for above change?
>>>>
>>>> If you need for some .sh, coresight test's to have x set while all of
>>>> the others don't have, and you have a good reason for that, ok, we just
>>>> add a comment.
>>>
>>> Simply to say, all lib scripts are not needed for execute permission.
>>> Yes, it's good to add a comment for the installation steps.
>>>
>>>>>>    DESCEND plugins
>>>>>>    GEN     /tmp/build/perf/python/perf.so
>>>>>>    INSTALL trace_plugins
>>>>>>    INSTALL binaries
>>>>>>    INSTALL tests
>>>>>> install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
>>>>>> make[2]: *** [Makefile.perf:1007: install-tests] Error 1
>>>>>> make[2]: *** Waiting for unfinished jobs....
>>>>>>
>>>>>> I'll add it back when the first .sh gets added to tests/shell/coresight/
>>>>>
>>>>> Sorry for introducing extra efforts for you and thanks!
>>>>
>>>> This also has to go, I'll check and fix this loop that doesn't follow
>>>> the existing output style, happens with ´make install', etc too:
>>>>
>>>> ⬢[acme@toolbox perf]$ make -C tools/perf clean
>>>> make: Entering directory '/var/home/acme/git/perf/tools/perf'
>>>>    CLEAN   x86
>>>>    CLEAN   libtraceevent
>>>>    CLEAN   libapi
>>>>    CLEAN   libbpf
>>>>    CLEAN   libsubcmd
>>>>    CLEAN   libperf
>>>>    CLEAN   fixdep
>>>>    CLEAN   feature-detect
>>>>    CLEAN   python
>>>>    CLEAN   bpf-skel
>>>> make -C asm_pure_loop clean >/dev/null        <-------------------
>>>> make -C memcpy_thread clean >/dev/null        <-------------------
>>>> make -C thread_loop clean >/dev/null          <-------------------
>>>> make -C unroll_loop_thread clean >/dev/null   <-------------------
>>>
>>> Ouch, if we can update the file tests/shell/coresight/Makefile as below:
>>>
>>> $(CLEANDIRS):
>>>          $(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
>>
>> I had to do it, so far, at the time that the above line is first added
>> as:
>>
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index a20b4adb5e3451f1..194e582e70c2c766 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -635,7 +635,8 @@ tests-coresight-targets: FORCE
>>   	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
>>   
>>   tests-coresight-targets-clean:
>> -	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
>> +	$(call QUIET_CLEAN, coresight)
>> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) O=$(OUTPUT) clean >/dev/null
>>   
>>   all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
>>   
>> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
>> index 3fee05cfcb0e73f6..6baab5cbaa9aa3b1 100644
>> --- a/tools/perf/tests/shell/coresight/Makefile
>> +++ b/tools/perf/tests/shell/coresight/Makefile
>> @@ -20,6 +20,6 @@ CLEANDIRS = $(SUBDIRS:%=clean-%)
>>   
>>   clean: $(CLEANDIRS)
>>   $(CLEANDIRS):
>> -	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
>> +	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
>>   
>>   .PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> 
> And for the normal build and install, somehow that $(Q) is not being
> obeyed there, so I'm using straight @ for now so that we have a clean
> output, someone more knowledgeable in the Makefile voodoo can then fix
> it.
> 
> ⬢[acme@toolbox perf]$ git log --oneline -1
> e1700b67a41092a5 (HEAD) perf test: Add build infra for perf test tools for ARM CoreSight tests
> ⬢[acme@toolbox perf]$ git diff
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> index 6baab5cbaa9aa3b1..6f3b3f07049c2d53 100644
> --- a/tools/perf/tests/shell/coresight/Makefile
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -8,13 +8,13 @@ SUBDIRS =
> 
>   all: $(SUBDIRS)
>   $(SUBDIRS):
> -       $(Q)$(MAKE) -C $@
> +       @$(MAKE) -C $@

DOn't you want to prefix this with + too (to preserve jobserver, i.e. 
parallel builds)?

Re the Q -- is it exported? What is printed with echo $(Q).

> 
>   INSTALLDIRS = $(SUBDIRS:%=install-%)
> 
>   install-tests: $(INSTALLDIRS)
>   $(INSTALLDIRS):
> -       $(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +       @$(MAKE) -C $(@:install-%=%) install-tests >/dev/null
> 
>   CLEANDIRS = $(SUBDIRS:%=clean-%)
> 
> ⬢[acme@toolbox perf]$

-- 
js

