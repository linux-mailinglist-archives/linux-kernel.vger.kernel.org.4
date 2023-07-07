Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7033C74B4D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjGGQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjGGQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:03:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A001BD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:03:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8c81e36c0so9807205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688745784; x=1691337784;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0VqBIALrcd8mBVd81Rng9Cgue3ve8H7Klx3ry8qJ1c=;
        b=JDBQ1wBiD3a/sXWfUQ730dyrmw5jo68RcTwMpLltrbxz8+GeU755yZR0/7MvzTfuWl
         v8LUr/cVcvYriYHNLBs/fwF5/b0b6LHK87tJa4Dlj51kbIs7XfEhTWs31ctvE1/Od6WM
         ofZNxuU/8+aHUkM50iufvfEdhtD51/gCKLx+rOSvxliHoybfdHN4AIK3eNP9+AQpUANI
         1waIVPvdS08wDE/OQmi2sulIZOLT14DwcoYQo/TI/PKnvhSmQPlwIN8b7pojE4pvJ341
         7yLNXGbZk6hcVAwmHkva/1Ge+2gI4OhBl6Jn+XEEfKSSyAtfZDfaZ27rjsD9uYB+7YJr
         31nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745784; x=1691337784;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0VqBIALrcd8mBVd81Rng9Cgue3ve8H7Klx3ry8qJ1c=;
        b=IJPxcLIsD0oU+9zwqHvllzPGSHmvSfInAYtN3cVPIPJRFo8OQUPRhIFvP3jRve2Ct/
         rm5T7xsj0yb0AlVOBzXd+JYr/dAkJx5I0liJo3t6qvEARz5+cdgUt8NXtrR8dt5sGg5q
         2OGR9UvbhppVMnXwPscTkZD0D8lIiRGw+11CtURHUyeIlUgzeOC8ZtUwP2MSM4gzvfKR
         214TctrNiFX2V2b06sPQEEKVlfyZLY3pFPRkBTx10MlCUv4sNJ1YMs1a/wRHnplY9H7i
         QJ/Bsl1lNFqk3eNxJ/xGv1KlHtKkJMzRuvyTORLSiW+zTTUWh0wUqJdYW/UBxbSDip3A
         i0fg==
X-Gm-Message-State: ABy/qLb0tBQdi7hMk3ueLDHvd9QvHCx3a5RWVEfhj9kejYAPgD4nHft/
        LENOAJwT0wXcR3I3C0qRg4JmDQ==
X-Google-Smtp-Source: APBJJlGwnL8Qj3bmfjdd9ej0p9JbpDKKaBE7bfwbyGePcVWmqfQqXEQFnZpLqWjudNruERaqtEacZg==
X-Received: by 2002:a17:902:ab01:b0:1b8:1fe3:bd2c with SMTP id ik1-20020a170902ab0100b001b81fe3bd2cmr3895162plb.20.1688745783547;
        Fri, 07 Jul 2023 09:03:03 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b001b03b7f8adfsm3437356plf.246.2023.07.07.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:03:03 -0700 (PDT)
Date:   Fri, 07 Jul 2023 09:03:03 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jul 2023 09:02:55 PDT (-0700)
Subject:     Re: [PATCH] module: Ignore RISC-V mapping symbols too
In-Reply-To: <3e905882-7f96-4fc0-aecf-6054ed00372e@t-8ch.de>
CC:     mcgrof@kernel.org, rdunlap@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     thomas@t-8ch.de
Message-ID: <mhng-1edd26e8-9307-4579-b50b-beceef92ccb9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 23:06:19 PDT (-0700), thomas@t-8ch.de wrote:
> On 2023-07-06 22:40:01-0700, Palmer Dabbelt wrote:
>> RISC-V has an extended form of mapping symbols that we use to encode
>> the ISA when it changes in the middle of an ELF.  This trips up modpost
>> as a build failure, I haven't yet verified it yet but I believe the
>> kallsyms difference should result in stacks looking sane again.
>
>> [..]
>
>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
>> index ef73ae7c8909..1e988e542c5d 100644
>> --- a/kernel/module/kallsyms.c
>> +++ b/kernel/module/kallsyms.c
>> @@ -12,6 +12,12 @@
>>  #include <linux/bsearch.h>
>>  #include "internal.h"
>>
>> +#ifdef CONFIG_RISCV
>> +#define IS_RISCV 1
>> +#else
>> +#define IS_RISCV 0
>> +#endif
>> +
>>  /* Lookup exported symbol in given range of kernel_symbols */
>>  static const struct kernel_symbol *lookup_exported_symbol(const char *name,
>>  							  const struct kernel_symbol *start,
>> @@ -289,7 +295,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>>  		 * and inserted at a whim.
>>  		 */
>>  		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
>> -		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
>> +		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_RISCV))
>
> IS_BUILTIN(CONFIG_RISCV) or IS_ENABLED(CONFIG_RISCV) ?

Thanks, this is fixed in the v2.

>
>>  			continue;
>>
>>  		if (thisval <= addr && thisval > bestval) {
>
>> [..]
