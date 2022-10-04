Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F955F42F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJDMeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJDMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:02 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C3632A99
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:34:00 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 76A5440D403D;
        Tue,  4 Oct 2022 12:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 76A5440D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1664886834;
        bh=5uFmnjSX/bP21/a/G90UL9zH+krUTH6cOaI4d++V8JM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XfjDE0UO+hC1Jx4XlFhmLbTzllcsU0wT5FwtfcOMCsnc+0cloJzuybfaMSHCmiG/T
         hJhPX2w/rmmM3S84bUKzEFnzIiwl55+B+Mn54mbIuHc3dpPXYhXypaKp1YkD0ZR03e
         MWSwFgHMR4L/9zvhFBwQCUod0+sBKwyIUF9dr5b8=
MIME-Version: 1.0
Date:   Tue, 04 Oct 2022 15:33:54 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v6 2/5] x86: Add cmdline_prepare() helper
In-Reply-To: <Yzcnt2oDiGHo10kP@zn.tnic>
References: <cover.1661565218.git.baskov@ispras.ru>
 <fc6713d1cb670313cdb61cc6f929dddc110f25d9.1661565218.git.baskov@ispras.ru>
 <Yzcnt2oDiGHo10kP@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b165c09447227c02fe3d8fe71c3bb529@ispras.ru>
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

On 2022-09-30 20:30, Borislav Petkov wrote:
> On Sat, Aug 27, 2022 at 05:08:07AM +0300, Evgeniy Baskov wrote:
>> +/*
>> + * command_line and boot_command_line are expected to be at most
>> + * COMMAND_LINE_SIZE length. command_line needs to be initialized
>> + * with COMMAND_LINE_INIT.
>> + */
>> +static inline void cmdline_prepare(char *command_line,
>> +				   const char *boot_command_line)
>> +{
>> +#ifdef CONFIG_CMDLINE_BOOL
> 
> Right, this is an ifdef...
> 
>> +	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> 
> ... but this is a IS_ENABLED().
> 
> Why?
> 
> I think we should stick to one.

Right, I'll change #ifdef to IS_ENABLED() and resubmit.
Originally it was like that because CONFIG_CMDLINE was used
in one of the #ifdef branches and it's no longer needed.

Thanks,
Evgeniy Baskov
