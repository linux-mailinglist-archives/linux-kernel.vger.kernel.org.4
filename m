Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69A60C959
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJYKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiJYKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:04:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601515CB3A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:59:12 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29P9xAOB031963;
        Tue, 25 Oct 2022 18:59:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 25 Oct 2022 18:59:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29P9xAnV031959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Oct 2022 18:59:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <86b65dc6-466c-abbd-0601-d07923bc3d10@I-love.SAKURA.ne.jp>
Date:   Tue, 25 Oct 2022 18:59:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
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
 <a130dc1f-a187-2957-25c1-974fb9c2569f@I-love.SAKURA.ne.jp>
 <753dfbe8-c68c-5e16-c4d0-1e14cd831c2e@schaufler-ca.com>
 <55f27f99-3a2b-3482-6dc2-12203948dd35@I-love.SAKURA.ne.jp>
 <7263e155-9024-0508-370c-72692901b326@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <7263e155-9024-0508-370c-72692901b326@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Oops. I chose a wrong mail. Replying to intended mail.)

On 2022/10/25 1:37, Casey Schaufler wrote:
>>  What I'm insisting is that "warrant the freedom to load
>> loadable LSM modules without recompiling the whole kernel".
> 
> Since security modules are optional and the LSM infrastructure
> itself is optional you can't ensure that any given kernel would
> support a loadable security module.

Like I propose adding EXPORT_SYMBOL_GPL(security_hook_heads),
I'm not taking about distributors who choose CONFIG_SECURITY=n.

>> Adding EXPORT_SYMBOL_GPL(security_hook_heads) is the only way that can "allow
>> LSM modules which distributors cannot support to be legally loaded".
> 
> I believe that I've identified an alternative. It isn't easy or cheap.

No. You are just handwaving/postponing the problem using something unknown
that is not yet shown as a workable code. Anything that can be disabled via
kernel config option cannot be an alternative.

  Quoting from https://lkml.kernel.org/r/2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp
  > Like Paul Moore said
  > 
  >   However, I will caution that it is becoming increasingly difficult for people
  >   to find time to review potential new LSMs so it may a while to attract sufficient
  >   comments and feedback.
  > 
  > , being unable to legally use loadable LSMs deprives of chances to develop/try
  > new LSMs, and makes LSM interface more and more unattractive. The consequence
  > would be "The LSM interface is dead. We will give up implementing as LSMs."

The biggest problem is that quite few developers show interest in loadable LSM modules.
How many developers responded to this topic? Once the ability to allow loadable LSM
modules is technically lost, nobody shall be able to revive it. You will be happy with
ignoring poor people.

You are already and completely trapped into "only in-tree and supported by distributors
is correct" crap.

> Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
> security modules. That's one of many reasons loadable modules are going to
> have to be treated differently from built-in modules, if they're allowed
> at all.

Then, I have to hate your idea of having fixed sized array.

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

