Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5D6946F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBMNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBMNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:24:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617821A675
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:24:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF8041F37C;
        Mon, 13 Feb 2023 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676294684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFeeD/FeoAftAse3SY9UYdhWJJuUONcBCw7GnWfvrC4=;
        b=YPLiEzL7evBGnHW8y3jLpspKY2gaLR1UBaa7Zhq7w6xOrKiO+zNV9rANi6akR12tElzClr
        xAnjsAli7kFhb6QNkyJFWC6HFbRPCId7xVPCbdb4mb6cxIEtNYnSeKZlSa7ZyHHaUnjm3w
        SFM+dHMJqfWSEjlQWZHG8n1mjOt7tWE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D07921391B;
        Mon, 13 Feb 2023 13:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NCGIMBw66mPrXgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 13 Feb 2023 13:24:44 +0000
Date:   Mon, 13 Feb 2023 14:24:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     huyd12@chinatelecom.cn
Cc:     liuq131@chinatelecom.cn, akpm@linux-foundation.org,
        agruenba@redhat.com, 'Christian Brauner' <christian@brauner.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] pid: add handling
 of too many zombie processes
Message-ID: <Y+o6HKUY/OzThJe/@dhcp22.suse.cz>
References: <20230208094905.373-1-liuq131@chinatelecom.cn>
 <000e01d93c56$3a4bcb00$aee36100$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000e01d93c56$3a4bcb00$aee36100$@chinatelecom.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-02-23 15:14:57, huyd12@chinatelecom.cn wrote:
> 
> Any comments will be appreciated.
> 
> 
> 
> -----邮件原件-----
> 发件人: liuq131@chinatelecom.cn <liuq131@chinatelecom.cn> 
> 发送时间: 2023年2月8日 17:49
> 收件人: akpm@linux-foundation.org
> 抄送: agruenba@redhat.com; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> huyd12@chinatelecom.cn; liuq <liuq131@chinatelecom.cn>
> 主题: [PATCH] pid: add handling of too many zombie processes
> 
> There is a common situation that a parent process forks many child processes
> to execute tasks, but the parent process does not execute wait/waitpid when
> the child process exits, resulting in a large number of child processes
> becoming zombie processes.
> 
> At this time, if the number of processes in the system out of
> kernel.pid_max, the new fork syscall will fail, and the system will not be
> able to execute any command at this time (unless an old process exits)
> 
> eg:
> [root@lq-workstation ~]# ls
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: Resource temporarily unavailable [root@lq-workstation ~]#
> reboot
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: retry: Resource temporarily unavailable
> -bash: fork: Resource temporarily unavailable
> 
> I dealt with this situation in the alloc_pid function, and found a process
> with the most zombie subprocesses, and more than 10(or other reasonable
> values?) zombie subprocesses, so I tried to kill this process to release the
> pid resources.

Abusing oom_kill_process is not the right approach. Also any hard coded limit
fir the number of zombies can turn out to be really tricky and it can
cause regressions.

Is there any reason you cannot contain those misbehaving workloads in a
pid controller?
-- 
Michal Hocko
SUSE Labs
