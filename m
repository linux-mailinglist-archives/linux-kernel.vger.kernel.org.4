Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BD60923D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJWKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJWKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:11:36 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2546EF15
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 03:11:34 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29NABW6a014366;
        Sun, 23 Oct 2022 19:11:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 23 Oct 2022 19:11:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29NAAh1h014195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Oct 2022 19:11:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <280c313e-c826-3b9c-a074-2ead3cf4107f@I-love.SAKURA.ne.jp>
Date:   Sun, 23 Oct 2022 19:10:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
Content-Language: en-US
In-Reply-To: <a130dc1f-a187-2957-25c1-974fb9c2569f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/23 16:27, Tetsuo Handa wrote:
> On 2022/10/21 8:42, Casey Schaufler wrote:
>> I will, on the other hand, listen to compelling arguments. It is not the
>> intention of this code to lock out loadable modules. If I thought it would
>> I would not have proposed it.
> 
> This code is exactly for locking out loadable modules.
> 

Imagine a situation where two individuals independently develop their own
web applications using the same identifier, and then their web applications
started working together with other web applications using that identifier.
When they published their web applications for public and wider use, a problem
that both web applications are already using the same identifier arises.
It is too late to reassign the identifier.

The same trouble can happen with loadable LSM modules. Unless the upstream kernel
behaves as if a DNS registerer that assigns a unique domainname for whatever web
sites (regardless of whether a web site is for public or not), defining a permanent
constant for LSM module is a way towards locking out loadable LSM modules. And it
is well possible that a loadable LSM module wants to run on older kernels which
do not have LSM id defined yet.

This "define LSM id as userspace visible constant" is more dangerous than just
reserving some space for future use. You are trying to control all IP addresses
for the sake of only in-tree LSM modules. No, no, no, please don't do that...

