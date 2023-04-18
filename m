Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7C6E6620
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDRNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDRNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756A210B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:41:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BB871F8D7;
        Tue, 18 Apr 2023 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681825298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iAAQ0frQqJj6843+qn+YG/AGqrm/NXD2JEWPvg2PLWM=;
        b=kDGIMux5X/IdSRGLRwvqLK/weGYG8HzbycZzmuGCDPXvpEysKE294uhfVRVC7FQ3hxOJjq
        DkGuudn4XrlRc1fZwu1VgT5aftQw9LOXUjQGuo1ANkLIHoGGeoY+jUQUe+4ba6Jp3PqYOR
        Od3UOFEtapsAUHFRSCOOQyBflO3zjUk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A317B2C141;
        Tue, 18 Apr 2023 13:41:37 +0000 (UTC)
Date:   Tue, 18 Apr 2023 15:41:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <ZD6eC9UBxwg-sG5_@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <ZD1f-1JjpihR1djd@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD1f-1JjpihR1djd@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-04-17 16:04:27, Chris Down wrote:
> (To others on this thread wondering about this patchset, Petr and I have had
> some discussions offlist about v4 and it should be up soon.)
> 
> Petr Mladek writes:
> > I thought a lot how to do it a clean way. IMHO, it would be great to
> > parse everything at a single place but it might require updating
> > all drivers. I am not sure if it is worth it.
> > 
> > So, I suggest to do it another way. We could implement a generic
> > function to find in the new key[:value] format. It would check
> > if the given option (key) exists and read the optional value.
> > 
> > The optional value would allow to define another new options
> > that would not need any value, e.g. "kthread" or "atomic" that
> > might be used in the upcoming code that allows to offload
> > console handling to kthreads.
> 
> Any thoughts on something simple like this that takes advantage of
> memmove()? This should overcome the mmio/io concerns, and it's fairly
> simple.
> 
> ---
> 
> static bool find_and_remove_console_option(char *buf, size_t size,
> 					   const char *wanted, char *options)

Nit: I would change the ordering of the parameters. The above uses
     the semantic of copy functions (desc, src). But this function
     is more about searching or reading. I would use semantic like
     strchr() or read() (where, what, buf).

     Also I would use the key:value names.

     Something like:

static bool
find_and_remove_console_option(char *options, const char
			       char *val_buf, size_t val_buf_size)

> {
> 	bool found = false, first = true;
> 	char *item, *opt = options;

Nit: I would rename these:

   + item -> option: the function is searching for an option that
	has the format value:key.

   + opt -> next: make it more clear that it points behind the
	currently proceed option (string token).

> 	while ((item = strsep(&opt, ","))) {
> 		char *key = item, *value;
> 
> 		value = strchr(item, ':');
> 		if (value)
> 			*(value++) = '\0';
> 
> 		if (strcmp(key, wanted) == 0) {
> 			found = true;
> 			if (value) {
> 				if (strlen(value) > size - 1) {
> 					pr_warn("Can't copy console option value for %s:%s: not enough space (%zu)\n",
> 						key, value, size);
> 					found = false;
> 				} else {
> 					strscpy(buf, value, size);
> 				}
> 			} else
> 				*buf = '\0';
> 		}
> 
> 		if (!found && opt)
> 			*(opt - 1) = ',';
> 		if (!found && value)
> 			*(value - 1) = ':';
> 		if (!first)
> 			*(item - 1) = ',';

This last assigned should not be needed. The above code replaced
at max one ',' and one ':'. It should be enough to restore
just the two.

> 		if (found)
> 			break;
> 
> 		first = false;
> 	}
> 
> 	if (found) {
> 		if (opt)
> 			memmove(item, opt, strlen(opt) + 1);
> 		else if (first)
> 			*item = '\0';
> 		else
> 			*--item = '\0';
> 	}
> 
> 	return found;
> }

Otherwise, it looks correct.

Note: I though about using strnchr() and strncmp() instead of
      replacing/restoring the two delimiters by '\0'.
      But the code looks more hairy in the end.

      Just for record, here is my attempt:

static bool
find_and_remove_console_option(char *options, const char *key,
			       char *val_buf, size_t val_buf_size)
{
	char *start, *next, *val;
	int option_len, key_len, found_key_len;
	bool found = false;

	if (val_buf && val_buf_size)
		*val_buf = '\0';

	key_len = strlen(key);
	next = options;
	do {
		start = next;
		next = strchr(start, ',');
		if (next) {
			option_len = next - start;
			next++;
		} else {
			option_len = strlen(start);
		}

		val = strnchr(start, option_len, ':');
		if (val) {
			found_key_len = val - start;
			val++;
		} else {
			found_key_len = option_len;
		}

		if (key_len != found_key_len)
			continue;

		if (!strncmp(start, key, key_len)) {
			found = true;
			break;
		}
	} while (next);

	if (found && val) {
		int val_len = option_len - key_len - 1;

		if (!val_buf || val_buf_size < val_len + 1) {
			pr_err("Can't copy value for the console option key: %s:%.*s\n",
			       key, val_len, val);
			return false;
		}

		strscpy(val_buf, val, val_len + 1);
	}

	/* Remove the found value[:key][,] */
	if (found) {
		if (next)
			memmove(start, next, strlen(next) + 1);
		else if (start == options)
			*options = '\0';
		else
			*(start - 1) = '\0';
	}

	return found;
}

Best Regards,
Petr
