Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4614E60BC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiJXV5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJXV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:57:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0B2BC6DB;
        Mon, 24 Oct 2022 13:11:29 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29OFDhBf078266;
        Tue, 25 Oct 2022 00:13:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Tue, 25 Oct 2022 00:13:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29OFDhop078262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Oct 2022 00:13:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <55f27f99-3a2b-3482-6dc2-12203948dd35@I-love.SAKURA.ne.jp>
Date:   Tue, 25 Oct 2022 00:13:40 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <753dfbe8-c68c-5e16-c4d0-1e14cd831c2e@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/24 2:13, Casey Schaufler wrote:
>> We won't be able to accept whatever LSM modules to upstream, and we won't
>> be able to enable whatever LSM modules in distributor kernels.
> 
> A built in module loader security module would address this issue.
> Getting such a module accepted upstream is not going to be trivial,
> but the BPF people seem to have managed it.

How can we guarantee that a built-in module loader security module is
always built-in ? What I'm insisting is that "warrant the freedom to load
loadable LSM modules without recompiling the whole kernel".

Sure, we can load LSM modules which were not built into distributor kernels
if we can recompile the whole kernel". But give me a break, that's a stupid
opinion for non-kernel developers. People won't replace distributor kernels
with rebuilt kernels only for enabling LSM modules which were not built into
distributor kernels.

Quoting from https://lkml.kernel.org/r/7f9ffd77-a329-ab13-857b-f8e34b2bfc77@schaufler-ca.com

  > I'm waiting to see what happens if eBPF security modules
  > become popular. I can easily see distributions turning the BPF LSM off.

Even if TOMOYO could be rewritten in eBPF (I don't think it is possible), how TOMOYO
can be loaded into distributor kernels if distributions turn the BPF LSM off ?

  > Before I go any further, I think that the loadable module manager LSM would be
  > very hard to get upstream.

Not only it will be very hard to get the loadable module manager LSM upstream,
it will be also very hard to keep the loadable module manager LSM enabled in
distributor kernels.

Again, how can we guarantee that a built-in module loader security module is
always built-in ?

What I'm insisting is that "warrant the freedom to load loadable LSM modules
without recompiling the whole kernel".

Adding EXPORT_SYMBOL_GPL(security_hook_heads) is the only way that can "allow
LSM modules which distributors cannot support to be legally loaded".

Any fixed-sized array like lsm_idlist[LSMID_ENTRIES] that defines max capacity
based on whether that LSM module is built-in will lock out loadable LSM modules.
Thus, I'm not happy with LSMID_ENTRIES.



On 2022/10/24 2:20, Casey Schaufler wrote:
> On 10/23/2022 3:10 AM, Tetsuo Handa wrote:
>> On 2022/10/23 16:27, Tetsuo Handa wrote:
>>> On 2022/10/21 8:42, Casey Schaufler wrote:
>>>> I will, on the other hand, listen to compelling arguments. It is not the
>>>> intention of this code to lock out loadable modules. If I thought it would
>>>> I would not have proposed it.
>>> This code is exactly for locking out loadable modules.
>>>
>> Imagine a situation where two individuals independently develop their own
>> web applications using the same identifier, and then their web applications
>> started working together with other web applications using that identifier.
>> When they published their web applications for public and wider use, a problem
>> that both web applications are already using the same identifier arises.
>> It is too late to reassign the identifier.
>>
>> The same trouble can happen with loadable LSM modules. Unless the upstream kernel
>> behaves as if a DNS registerer that assigns a unique domainname for whatever web
>> sites (regardless of whether a web site is for public or not), defining a permanent
>> constant for LSM module is a way towards locking out loadable LSM modules. And it
>> is well possible that a loadable LSM module wants to run on older kernels which
>> do not have LSM id defined yet.
>>
>> This "define LSM id as userspace visible constant" is more dangerous than just
>> reserving some space for future use. You are trying to control all IP addresses
>> for the sake of only in-tree LSM modules. No, no, no, please don't do that...
> 
> It's really no more dangerous than using the LSM name. What if two developers
> implement modules and both name it "belllapadula"? User space won't be able to
> tell the difference if they base behavior on the module name. That's one thing
> that a loadable module mechanism is going to need to address that a built-in
> mechanism doesn't. 

If the upstream kernel assigns an LSM id for all LSM modules including out-of-tree
and/or private LSM modules (that's why I described that the upstream kernel behaves
as if a DNS registerer), we can assign LSM id = 100 to "belllapadula" from A and
LSM id = 101 to "belllapadula" from B, and both "belllapadula" modules can work
without conflicts by using LSM id. Of course, this implies that we need to preserve
unused space in lsm_idlist[LSMID_ENTRIES] etc. for such LSM modules (if we use
fixed-sized array rather than a linked list).

