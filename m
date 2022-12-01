Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343BB63E64A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLAAPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLAAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:15:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB9A2816
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 16:09:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293FC60A2A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF8C433D7;
        Thu,  1 Dec 2022 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669853344;
        bh=Um3WQhBTYgWaLQy6MGpy/qOcoDY69AWToZC6FBCV2yY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=T7wHujeay5HaWs2My7e+orkGiaJ2roz7fb2Vjfhfx6RY7x9Bn1JblD5G4OuL6N1su
         RlSSjLC1mCaSTrpTJOHmVCAJBeY/UdB2VkWAqZGMCZNlHFnto4lH63kEPlQ7zyNYxl
         PDagDJNR7AOrYYl5lIlr/OVho1FuFETOD9Y8uhFHj5vn2z8kmMpI7npyuDAqigFQym
         iqrGukfWVTiHeE89AKPNCN2VmKYUD+JnNxWtgh6zkLRcRNU22Uc8VeUQvtEavE1N5A
         qd1cH2d06VQcJxVkFHDjb1gEh1bt9pOJwetV/zoDCkPUeD6k8clusj8fOfUFsp7VcF
         ciw7obUfuGFOA==
Message-ID: <2f8c4d57-1834-146b-07c4-11d6c87d986d@kernel.org>
Date:   Wed, 30 Nov 2022 16:09:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] kest.pl: Fix grub2 menu handling for rebooting
Content-Language: en-MW
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221130175434.555ea650@gandalf.local.home>
From:   John 'Warthog9' Hawley <warthog9@kernel.org>
In-Reply-To: <20221130175434.555ea650@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 14:54, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> grub2 has submenus where to use grub-reboot, it requires:
> 
>    grub-reboot X>Y
> 
> where X is the main index and Y is the submenu. Thus if you have:
> 
> menuentry 'Debian GNU/Linux' --class debian --class gnu-linux ...
> 	[...]
> }
> submenu 'Advanced options for Debian GNU/Linux' $menuentry_id_option ...
>          menuentry 'Debian GNU/Linux, with Linux 6.0.0-4-amd64' --class debian --class gnu-linux ...
>                  [...]
>          }
>          menuentry 'Debian GNU/Linux, with Linux 6.0.0-4-amd64 (recovery mode)' --class debian --class gnu-linux ...
> 		[...]
>          }
>          menuentry 'Debian GNU/Linux, with Linux test' --class debian --class gnu-linux ...
>                  [...]
>          }
> 
> And wanted to boot to the "Linux test" kernel, you need to run:
> 
>   # grub-reboot 1>2
> 
> As 1 is the second top menu (the submenu) and 2 is the third of the sub
> menu entries.
> 
> Have the grub.cfg parsing for grub2 handle such cases.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>   tools/testing/ktest/ktest.pl | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 799cfc4aa12b..590518144167 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -1963,7 +1963,7 @@ sub run_scp_mod {
>   
>   sub _get_grub_index {
>   
> -    my ($command, $target, $skip) = @_;
> +    my ($command, $target, $skip, $submenu) = @_;
>   
>       return if (defined($grub_number) && defined($last_grub_menu) &&
>   	$last_grub_menu eq $grub_menu && defined($last_machine) &&
> @@ -1980,11 +1980,16 @@ sub _get_grub_index {
>   
>       my $found = 0;
>   
> +    my $submenu_number = 0;
> +
>       while (<IN>) {
>   	if (/$target/) {
>   	    $grub_number++;
>   	    $found = 1;
>   	    last;
> +	} elsif (defined($submenu) && /$submenu/) {
> +		$submenu_number++;
> +		$grub_number = -1;
>   	} elsif (/$skip/) {
>   	    $grub_number++;
>   	}
> @@ -1993,6 +1998,9 @@ sub _get_grub_index {
>   
>       dodie "Could not find '$grub_menu' through $command on $machine"
>   	if (!$found);
> +    if ($submenu_number > 0) {
> +	$grub_number = "$submenu_number>$grub_number";
> +    }
>       doprint "$grub_number\n";
>       $last_grub_menu = $grub_menu;
>       $last_machine = $machine;
> @@ -2003,6 +2011,7 @@ sub get_grub_index {
>       my $command;
>       my $target;
>       my $skip;
> +    my $submenu;
>       my $grub_menu_qt;
>   
>       if ($reboot_type !~ /^grub/) {
> @@ -2017,8 +2026,9 @@ sub get_grub_index {
>   	$skip = '^\s*title\s';
>       } elsif ($reboot_type eq "grub2") {
>   	$command = "cat $grub_file";
> -	$target = '^menuentry.*' . $grub_menu_qt;
> -	$skip = '^menuentry\s|^submenu\s';
> +	$target = '^\s*menuentry.*' . $grub_menu_qt;
> +	$skip = '^\s*menuentry';
> +	$submenu = '^\s*submenu\s';
>       } elsif ($reboot_type eq "grub2bls") {
>   	$command = $grub_bls_get;
>   	$target = '^title=.*' . $grub_menu_qt;
> @@ -2027,7 +2037,7 @@ sub get_grub_index {
>   	return;
>       }
>   
> -    _get_grub_index($command, $target, $skip);
> +    _get_grub_index($command, $target, $skip, $submenu);
>   }
>   
>   sub wait_for_input {
> @@ -2090,7 +2100,7 @@ sub reboot_to {
>       if ($reboot_type eq "grub") {
>   	run_ssh "'(echo \"savedefault --default=$grub_number --once\" | grub --batch)'";
>       } elsif (($reboot_type eq "grub2") or ($reboot_type eq "grub2bls")) {
> -	run_ssh "$grub_reboot $grub_number";
> +	run_ssh "$grub_reboot \"'$grub_number'\"";
>       } elsif ($reboot_type eq "syslinux") {
>   	run_ssh "$syslinux --once \\\"$syslinux_label\\\" $syslinux_path";
>       } elsif (defined $reboot_script) {

Ahhh the fun of submenus!

Reviewed-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
