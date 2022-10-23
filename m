Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592176090C9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 04:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJWCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 22:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWCTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 22:19:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8313F27
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 19:19:13 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29N2I4V4009579;
        Sun, 23 Oct 2022 11:18:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 23 Oct 2022 11:18:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29N2I3UB009568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Oct 2022 11:18:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ce198a72-92c9-e09a-ca92-2860326c2938@I-love.SAKURA.ne.jp>
Date:   Sun, 23 Oct 2022 11:18:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [syzbot] general protection fault in _parse_integer_fixup_radix
Content-Language: en-US
To:     syzbot <syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0000000000002feb6605eb71458e@google.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Hawkins Jiawei <yin31149@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000002feb6605eb71458e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting that "vfs: parse: deal with zero length string value"
in linux-next.git broke tmpfs's mount option parsing, for tmpfs is expecting that
vfs_parse_fs_string() returning 0 implies that param.string != NULL.

The "nr_inodes" parameter for tmpfs is interpreted as "nr_inodes=$integer", but
the addition of

	if (!v_size) {
		param.string = NULL;
		param.type = fs_value_is_empty;
	} else {

to vfs_parse_fs_string() and

	if (param->type == fs_value_is_empty)
		return 0;

to fs_param_is_string() broke expectation by tmpfs.

  Parsing an fs string that has zero length should result in the parameter
  being set to NULL so that downstream processing handles it correctly.

is wrong and

  Parsing an fs string that has zero length should result in invalid argument
  error so that downstream processing does not dereference NULL param.string
  field.

is correct for the "nr_inodes" parameter.



How do we want to fix?
Should we add param.string != NULL checks into the downstream callers (like
Hawkins Jiawei did for https://syzkaller.appspot.com/bug?extid=a3e6acd85ded5c16a709 ) ?
Or should we add

	if (!*param.string)
		param.string = NULL;

rewriting into downstream callers which expect

  For example, the proc mount table processing should print "(none)" in this
  case to preserve mount record field count, but if the value points to the
  NULL string this doesn't happen.

behavior?

On 2022/10/20 15:16, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a72b55bc981b Add linux-next specific files for 20221019
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1728c644880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=200524babbc01b2a
> dashboard link: https://syzkaller.appspot.com/bug?extid=db1d2ea936378be0e4ea
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12afb08c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11001c72880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fa24fb5893fd/disk-a72b55bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cf1b7e7b579c/vmlinux-a72b55bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com
> 

