Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC476E2F92
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDOHus convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Apr 2023 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDOHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:50:46 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Apr 2023 00:50:44 PDT
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B34694
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:50:44 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id EA8B31A014F;
        Sat, 15 Apr 2023 07:43:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 6F63030;
        Sat, 15 Apr 2023 07:43:41 +0000 (UTC)
Date:   Sat, 15 Apr 2023 03:43:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
User-Agent: K-9 Mail for Android
In-Reply-To: <20230415070406.GJ25053@google.com>
References: <20230411143852.868524-1-senozhatsky@chromium.org> <ZDkWR2lq2MZ4r1aG@alley> <20230415070406.GJ25053@google.com>
Message-ID: <352F1D7E-35E2-4FDF-A88F-01E106537279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Queue-Id: 6F63030
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: at8fjhq4eepewehhfpbp4ddjkeefbf5k
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZMMhc9ga/WAK4PUZOe7mBKsJJ9Rn+oDM=
X-HE-Tag: 1681544621-247496
X-HE-Meta: U2FsdGVkX1+LSj3gbQ67bSOzEQZCVCihg0YZ3zQEh0IVGDm9zMdKfdu5Uzx+ZaLUtrzUY+N8EAybw8b6Us69Fw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 15, 2023 3:04:06 AM EDT, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>On (23/04/14 11:00), Petr Mladek wrote:
>> > +void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
>> > +{
>> > +	const char *start, *lf;
>> > +	int len;
>> > +
>> > +	if (s->size == 0 || s->len == 0)
>> > +		return;
>> > +
>> > +	seq_buf_terminate(s);
>> > +
>> > +	start = s->buffer;
>> > +	while ((lf = strchr(start, '\n'))) {
>> > +		len = lf - start + 1;
>> > +		printk("%s%.*s", lvl, len, start);
>> > +		start = ++lf;
>> > +	}
>> > +
>> > +	/* No trailing LF */
>> > +	if (start < s->buffer + s->len) {
>> > +		len = s->buffer + s->len - start;
>> > +		printk("%s%.*s\n", lvl, len, start);
>> 
>> We know that the string is '\0' terminated, so the last print
>> might be easier:
>> 
>> 	if (start < s->buffer + s->len)
>> 		printk("%s%s\n", lvl, start);
>
>Indeed. Steven, let me know if you'd prefer a v3.

Sure. Why not.

-- Steve

>
>> Anyway, it looks good. With or without this change:
>> 
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>Thanks Petr!

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
