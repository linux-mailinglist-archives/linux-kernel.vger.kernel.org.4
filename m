Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26460919E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJWH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJWH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:27:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BF5F98B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:27:16 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29N7RFOQ082330;
        Sun, 23 Oct 2022 16:27:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 23 Oct 2022 16:27:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29N7RE9v082325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Oct 2022 16:27:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a130dc1f-a187-2957-25c1-974fb9c2569f@I-love.SAKURA.ne.jp>
Date:   Sun, 23 Oct 2022 16:27:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-5-casey@schaufler-ca.com>
 <9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp>
 <f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/21 8:42, Casey Schaufler wrote:
> On 10/13/2022 3:04 AM, Tetsuo Handa wrote:
>> On 2022/09/28 4:53, Casey Schaufler wrote:
>>> @@ -483,6 +491,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>>  {
>>>  	int i;
>>>  
>>> +	/*
>>> +	 * A security module may call security_add_hooks() more
>>> +	 * than once. Landlock is one such case.
>>> +	 */
>>> +	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
>>> +		lsm_idlist[lsm_id++] = lsmid;
>>> +
>>> +	if (lsm_id > LSMID_ENTRIES)
>>> +		panic("%s Too many LSMs registered.\n", __func__);
>> I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.
> 
> I don't see any way given the locking issues that we're ever going to
> mix built in security modules and loaded security modules on the same
> hook lists. The SELinux module deletion code is sufficiently scary that
> it is being removed. That does not mean that I think loadable modules
> are impossible, I think it means that their management is going to have
> to be separate, the same way the BPF programs are handled. The only way
> that I see a unified hook list is for all the LSMs to be implemented as
> loadable modules, and I can't see that happening in my lifetime.

I'm not expecting for unloadable LSM modules.
I'm expecting for loadable LSM modules.

I'm not expecting to make all LSM modules to be implemented as loadable
LSM modules, for some want to associate "security label" to everything
(including processes which might start before the global init process starts)
but others do not need to associate "security label" to everything.

> 
> I can see an LSM like BPF, as I mentioned before, that manages loaded
> modules. Over the years I've seen several designs that might work. I'm
> encouraged (and not a little bit frightened) by the success of the BPF
> work.

There can be LSM modules whose lifetime of hooks match the lifetime of
a process which registered hooks for that process. In that case, being
automatically unregistered upon process termination would be preferable.

But there are LSM modules whose lifetime of hooks is irrelevant to a process
which registered a hook for that process. In that case, we need a method for
allowing registered hooks to remain even after that process terminated.

Please don't think loadable LSM modules as something that require special
handling. TOMOYO is an LSM module whose lifetime of hooks is irrelevant to
a process which registered a hook for that process, but does not need to
associate "security label" to everything. It has to be trivial to convert
TOMOYO as a loadable LSM module.

> 
> Converting the array[LSMID_ENTRIES] implementation to a hlist like the
> hooks have used would not be that big a project and I don't see that
> making such a change would be a show-stopper for implementing loadable
> modules. I think that a lot of other issues would be more significant.

Defining constants for each LSM module (i.e. "LSM: Add an LSM identifier
for external use") is the show-stopper for implementing loadable modules.
We won't be able to accept whatever LSM modules to upstream, and we won't
be able to enable whatever LSM modules in distributor kernels.

LSM modules which cannot define a constant due to either "not accepted
to upstream" or "not enabled by distributor kernels" will be forbidden.
I expect that we assign a constant upon module registration (instead of
API visible constants) if we require all LSM modules to have a constant.

> 
> I will, on the other hand, listen to compelling arguments. It is not the
> intention of this code to lock out loadable modules. If I thought it would
> I would not have proposed it.

This code is exactly for locking out loadable modules.

