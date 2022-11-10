Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78405623E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKJJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:59:54 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856CCFEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:59:53 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 73E07419E9E6;
        Thu, 10 Nov 2022 08:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 73E07419E9E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668070789;
        bh=neGJ6aPp1EP47ADs1Po8DwFHVwq/4DyspY6UhrLDIOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCXSDaMp2EnGPcJV+AWqTBU6ZoS4TPhH7pRV9peD3P56yvC1E2USN65ZKV0dKU2wN
         kAfmhBIWScQVlH49cWN0Uhd3ylAXctkoteUEdkjE2HPkFIWWmFMQkLc+MD3s67K99E
         P+GgXmzy9PoXCzLrmDd63Q9TL8Ll5C+UBxWnf6w4=
MIME-Version: 1.0
Date:   Thu, 10 Nov 2022 11:59:49 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v7 2/5] x86: Add cmdline_prepare() helper
In-Reply-To: <Y2wvjmpwpOWsc5WT@zn.tnic>
References: <cover.1664886978.git.baskov@ispras.ru>
 <603dc95beb44340aa1787328589ff2e073b251e1.1664886978.git.baskov@ispras.ru>
 <Y2wvjmpwpOWsc5WT@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7e718c64442469cce6b68988c607a240@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-10 01:54, Borislav Petkov wrote:
> On Tue, Oct 04, 2022 at 03:48:21PM +0300, Evgeniy Baskov wrote:
>> +static inline void cmdline_prepare(char *command_line,
>> +				   const char *boot_command_line)
>> +{
>> +	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
>> +		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>> +	} else if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
>> +		/* Append boot loader cmdline to builtin one. */
>> +		strlcat(command_line, " ", COMMAND_LINE_SIZE);
>> +		strlcat(command_line, boot_command_line, COMMAND_LINE_SIZE);
>> +	}
> 
> Why can't we make this plain and simple and understandable at a quick
> glance instead of putting parts of the string in some variable and then
> still doing copying outside of the function?
> 
> IOW, simply put everything in a single function:
> 
> static inline void cmdline_prepare(char *dst,
>                                    const char *builtin_cmdline,
>                                    const char *boot_command_line)
> {
>         /* Depends on CONFIG_CMDLINE_BOOL, overwrite with builtin 
> cmdline */
>         if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
>                 strscpy(dst, builtin_cmdline, COMMAND_LINE_SIZE);
>         else if (IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
>                 if (builtin_cmdline[0]) {
>                         /* append boot loader cmdline to builtin */
>                         srtlcat(dst, builtin_cmdline, 
> COMMAND_LINE_SIZE)
>                         strlcat(dst, " ", COMMAND_LINE_SIZE);
>                         strlcat(dst, boot_command_line, 
> COMMAND_LINE_SIZE);
>                 } else {
>                         strscpy(dst, boot_command_line, 
> COMMAND_LINE_SIZE);
>                 }
>         }
> }
> 
> which is then called like this:
> 
> 	cmdline_prepare(command_line, builtin_cmdline, boot_command_line);
> 
> and when it returns command_line is ready. And before it, command_line
> is the empty string:
> 
> static char __initdata command_line[COMMAND_LINE_SIZE];
> 
> And all the complexity is in one single function and that single
> function does each case in an obvious manner and you don't have to go
> look outside of the function body to understand what it does.
> 
> Hmmm?

Well, my version takes one less copy... But clarity is more important
in the kernel, I guess. I'll send updated version soon.

Thanks,
Evgeniy Baskov
