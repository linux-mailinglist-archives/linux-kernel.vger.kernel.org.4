Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6364C0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiLMXvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLMXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:51:16 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6465DB4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SIYlH3jyQM0ZotVnKMTJahO1+18k0UeyRqHK151oXCw=; b=h6OxnK0Hia6cBHVgqE0aBM67nc
        kVuK4sBzSdEpUrHmIx3tLY7JZ8GCvnAGazLHo+9GSTRCdIy3BcdJt5OthM8r9pvp0OIrViBEpQAYA
        /Rqc2OrnyWgqn+xEKji6L9mXG4tMQSHuVrgl63wdZGi/OAVZI4a3Pefxk47MCg40uvPY2XJZ3jzf5
        gkYyvYJCdfQBtafsbTo2/Kn5Ju2vZ/ul/fKMPVnDODQM/RfUXRzxJWMwvQXcpVeftE6jsacu/we3v
        DDMJcr/+fNf/QX+pyQyL+cBuxeGtCJ51h8OPTwK5E20v0e2gL17eSkCn+42PuW+xN53YCxR3ZgIIS
        fhO4WYBg==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5F3H-002r2P-FD; Wed, 14 Dec 2022 00:51:11 +0100
Message-ID: <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
Date:   Tue, 13 Dec 2022 20:51:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221020172908.25c6e3a5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 18:29, Steven Rostedt wrote:
> On Fri, 19 Aug 2022 19:17:26 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> Currently the tracing dump_on_oops feature is implemented through
>> separate notifiers, one for die/oops and the other for panic;
>> given they have the same functionality, let's unify them.
>>
>> Also improve the function comment and change the priority of the
>> notifier to make it execute earlier, avoiding showing useless trace
>> data (like the callback names for the other notifiers); finally,
>> we also removed an unnecessary header inclusion.
>>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Sorry for the late reply.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Hi Steve, since you were so kind in the other patch...decided to ping in
this one as well heheh

So, do you think it's possible to pick it for 6.2? No dependency here,
it's a standalone patch.

Thanks again and sorry for the annoyance!
Cheers,


Guilherme
