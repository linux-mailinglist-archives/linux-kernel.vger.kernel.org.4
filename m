Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA861F36C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiKGMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKGMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:35:11 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B82A270F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:35:11 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N5W0B3zmRzMq28x;
        Mon,  7 Nov 2022 13:35:06 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N5W093QzMzMppF4;
        Mon,  7 Nov 2022 13:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667824506;
        bh=AIfjDO6RbZU54N/eOPfjCho8loUCaxN2cuqpGiIthRU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JjylhgBSkoMA+3929dyUMhIj5NJnulWLnWVgaWz7FR0Ah+08kNqTIYTjQVWyXHOpz
         href5o8wK+a0hP8WYMU3PFhZ6P29VjRGc3LIb5cWj11DhYiJu5IAiPDwZQnI2qmHx5
         pdZIbvro97791JFjJLz5PcxsAb9MNJeABgaq30Ok=
Message-ID: <955d9b89-3ca1-8c70-0c05-759febde4031@digikod.net>
Date:   Mon, 7 Nov 2022 13:35:04 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
 <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
 <202210171111.21E3983165@keescook>
 <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
 <202210172153.C65BF23D5E@keescook>
 <CAHC9VhSMLjzxyu0F82NZoea-q4yMgHeCZ0-TRcvxKks4WeKacQ@mail.gmail.com>
 <c7808c82-621e-c20d-bff3-03a66df5528a@digikod.net>
 <b0e100f9-146c-2709-3946-67bc06282b91@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <b0e100f9-146c-2709-3946-67bc06282b91@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 18:20, Casey Schaufler wrote:
> On 11/4/2022 9:29 AM, Mickaël Salaün wrote:
>>
>> On 18/10/2022 21:31, Paul Moore wrote:
>>> On Tue, Oct 18, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
>>>> On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
>>
>> [...]
>>
>>>>> We can have defaults, like we do know, but I'm in no hurry to remove
>>>>> the ability to allow admins to change the ordering at boot time.
>>>>
>>>> My concern is with new LSMs vs the build system. A system builder will
>>>> be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
>>>> about making changes to CONFIG_LSM to include it.
>>>
>>> I would argue that if an admin/builder doesn't understand what a shiny
>>> new LSM does, they shouldn't be enabling that shiny new LSM.  Adding
>>> new, potentially restrictive, controls to your kernel build without a
>>> basic understanding of those controls is a recipe for disaster and I
>>> try to avoid recommending disaster as a planned course of action :)
>>
>> It depends on what this shiny new LSMs do *by default*. In the case of
>> Landlock, it do nothing unless a process does specific system calls
>> (same as for most new kernel features: sysfs entries, syscall flags…).
>> I guess this is the same for most LSMs.
> 
> "By default" is somewhat ambiguous. Smack will always enforce its
> basic policy. If files aren't labeled and the Smack process label
> isn't explicitly set there won't be any problems. However, if files
> have somehow gotten labels assigned and there are no rules defined
> things can go sideways.

Right, it should then mean without effect whatever kernel-mediated 
persistent data (e.g. FS's xattr), but I agree that the limit with an 
explicit configuration can be blurry. I guess we could explicitly mark 
LSMs with a property that specify if they consider safe (for the system) 
to be implicitly enabled without explicit run time configuration.
