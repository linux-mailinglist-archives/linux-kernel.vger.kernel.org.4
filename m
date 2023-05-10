Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290A6FE806
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEJXRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjEJXQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C92272D;
        Wed, 10 May 2023 16:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D037363806;
        Wed, 10 May 2023 23:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB645C433EF;
        Wed, 10 May 2023 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683760615;
        bh=vIO/pbMw7hd/LQtTLHhb36ZJL8+SKJcMQgnYYrxnEhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChMvym4BdgnKakXfPkF5zMnoEW8XICR+Jj2XR2zfe8O50HEh8QvBe2QaVjCXonsUT
         jVhvjk7t/nl43jboiRwtF6/lT+P7p9FotggtZg7Ec0nVL6Mh7wH+HWYrSnXZ0jfu38
         +wdNoYIUbvwdyyg1GXUiEVO9a2h75UeYhYqEhhb8=
Date:   Thu, 11 May 2023 08:16:47 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, laoar.shao@gmail.com
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <2023051127-coastline-buffer-061a@gregkh>
References: <20230509030611.521807993@linuxfoundation.org>
 <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh>
 <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
 <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
 <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net>
 <2023051154-activator-aside-bc8e@gregkh>
 <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NT7Vp7lOswVCjS8Z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NT7Vp7lOswVCjS8Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 10, 2023 at 06:09:35PM -0500, Linus Torvalds wrote:
> On Wed, May 10, 2023 at 5:58 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Thanks!  Turns out someone put the wrong "Fixes:" tag in that commit
> > which is why I missed it.
> 
> Hmm. Presumably the real commit ceeadb83aea2 at some point got
> rebased, and had had that other mentioned SHA1 before that.
> 
> It might be a good idea in general - not just for stable - if we had
> some automation that said "this refers to a commit ID that doesn't
> exist".

We have that in linux-next today (or at least we used to, I took the
scripts from linux-next and rely on them to catch this in my trees.)
I cleaned up the scripts and posted them to the kernel workgroup mailing
list a long time ago for any other maintainer to also use, I've attached
it below as well.

I run across this issue 2-3 times each -rc release, it's quite common
but very low overall.

thanks,

greg k-h

--NT7Vp7lOswVCjS8Z
Content-Type: application/x-sh
Content-Disposition: attachment; filename="verify_fixes.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A# SPDX-License-Identifier: GPL-2.0=0A#=0A# Copyright (C) 2019=
 Stephen Rothwell <sfr@canb.auug.org.au>=0A# Copyright (C) 2019 Greg Kroah-=
Hartman <gregkh@linuxfoundation.org>=0A#=0A# Verify that the "Fixes:" tag i=
s correct in a kernel commit=0A#=0A# usage:=0A#	verify_fixes.sh GIT_RANGE=
=0A#=0A# To test just the HEAD commit do:=0A#	verify_fixes.sh HEAD^..HEAD=
=0A#=0A#=0A# Thanks to Stephen Rothwell <sfr@canb.auug.org.au> for the majo=
rity of this code=0A#=0A=0A# Only thing you might want to change here, the =
location of where Linus's git=0A# tree is on your system:=0ALinus_tree=3D"/=
home/gregkh/linux/work/torvalds/"=0A=0A####################################=
######=0A# No need to touch anything below here=0A=0Asplit_re=3D'^([Cc][Oo]=
[Mm][Mm][Ii][Tt])?[[:space:]]*([[:xdigit:]]{5,})([[:space:]]*)(.*)$'=0Anl=
=3D$'\n'=0Atab=3D$'\t'=0A=0Ahelp()=0A{=0A	echo "error, git range not found"=
=0A	echo "usage:"=0A	echo "	$0 GIT_RANGE"=0A	exit 1=0A}=0A=0A# Strip the le=
ading and training spaces from a string=0Astrip_spaces()=0A{=0A	[[ "$1" =3D=
~ ^[[:space:]]*(.*[^[:space:]])[[:space:]]*$ ]]=0A	echo "${BASH_REMATCH[1]}=
"=0A}=0A=0Averify_fixes()=0A{=0A	git_range=3D$1=0A	error=3D0=0A	commits=3D$=
(git rev-list --no-merges -i --grep=3D'^[[:space:]]*Fixes:' "${git_range}")=
=0A	if [ -z "$commits" ]; then=0A	        return 0=0A	fi=0A=0A	for c in $co=
mmits; do=0A=0A		commit_log=3D$(git log -1 --format=3D'%h ("%s")' "$c")=0A#=
			commit_msg=3D"In commit:=0A#	$commit_log=0A#"=0A			commit_msg=3D"Commit:=
 $commit_log=0A"=0A=0A		fixes_lines=3D$(git log -1 --format=3D'%B' "$c" |=
=0A				grep -i '^[[:space:]]*Fixes:')=0A=0A		while read -r fline; do=0A			[=
[ "$fline" =3D~ ^[[:space:]]*[Ff][Ii][Xx][Ee][Ss]:[[:space:]]*(.*)$ ]]=0A		=
	f=3D"${BASH_REMATCH[1]}"=0A#			fixes_msg=3D"	Fixes tag:=0A#		$fline=0A#	Ha=
s these problem(s):=0A#"=0A			fixes_msg=3D"	Fixes tag: $fline=0A	Has these =
problem(s):=0A"=0A			sha=3D=0A			subject=3D=0A			msg=3D=0A			=0A			if git l=
og -1 --format=3D'%B' "$c" | tr '\n' '#' | grep -qF "##$fline##"; then=0A		=
		msg=3D"${msg:+${msg}${nl}}${tab}${tab}- empty lines surround the Fixes ta=
g"=0A			fi=0A			=0A			if [[ "$f" =3D~ $split_re ]]; then=0A				first=3D"${B=
ASH_REMATCH[1]}"=0A				sha=3D"${BASH_REMATCH[2]}"=0A				spaces=3D"${BASH_RE=
MATCH[3]}"=0A				subject=3D"${BASH_REMATCH[4]}"=0A				if [ "$first" ]; then=
=0A					msg=3D"${msg:+${msg}${nl}}${tab}${tab}- leading word '$first' unexp=
ected"=0A				fi=0A				if [ -z "$subject" ]; then=0A					msg=3D"${msg:+${msg=
}${nl}}${tab}${tab}- missing subject"=0A				elif [ -z "$spaces" ]; then=0A	=
				msg=3D"${msg:+${msg}${nl}}${tab}${tab}- missing space between the SHA1 =
and the subject"=0A				fi=0A			else=0A				printf '%s%s\t\t- %s\n' "$commit_=
msg" "$fixes_msg" 'No SHA1 recognised'=0A				commit_msg=3D''=0A				error=3D=
1=0A				continue=0A			fi=0A			if ! git rev-parse -q --verify "$sha" >/dev/n=
ull; then=0A				printf '%s%s\t\t- %s\n' "$commit_msg" "$fixes_msg" 'Target =
SHA1 does not exist'=0A				commit_msg=3D''=0A				error=3D1=0A				continue=
=0A			fi=0A=0A			if [ "${#sha}" -lt 12 ]; then=0A				msg=3D"${msg:+${msg}${=
nl}}${tab}${tab}- SHA1 should be at least 12 digits long${nl}${tab}${tab}  =
Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11${nl}$=
{tab}${tab}  or later) just making sure it is not set (or set to \"auto\").=
"=0A			fi=0A			# reduce the subject to the part between () if there=0A			if=
 [[ "$subject" =3D~ ^\((.*)\) ]]; then=0A				subject=3D"${BASH_REMATCH[1]}"=
=0A			elif [[ "$subject" =3D~ ^\((.*) ]]; then=0A				subject=3D"${BASH_REMA=
TCH[1]}"=0A				msg=3D"${msg:+${msg}${nl}}${tab}${tab}- Subject has leading =
but no trailing parentheses"=0A			fi=0A=0A			# strip matching quotes at the=
 start and end of the subject=0A			# the unicode characters in the classes =
are=0A			# U+201C LEFT DOUBLE QUOTATION MARK=0A			# U+201D RIGHT DOUBLE QUO=
TATION MARK=0A			# U+2018 LEFT SINGLE QUOTATION MARK=0A			# U+2019 RIGHT SI=
NGLE QUOTATION MARK=0A			re1=3D$'^[\"\u201C](.*)[\"\u201D]$'=0A			re2=3D$'^=
[\'\u2018](.*)[\'\u2019]$'=0A			re3=3D$'^[\"\'\u201C\u2018](.*)$'=0A			if [=
[ "$subject" =3D~ $re1 ]]; then=0A				subject=3D"${BASH_REMATCH[1]}"=0A			e=
lif [[ "$subject" =3D~ $re2 ]]; then=0A				subject=3D"${BASH_REMATCH[1]}"=
=0A			elif [[ "$subject" =3D~ $re3 ]]; then=0A				subject=3D"${BASH_REMATCH=
[1]}"=0A				msg=3D"${msg:+${msg}${nl}}${tab}${tab}- Subject has leading but=
 no trailing quotes"=0A			fi=0A=0A			subject=3D$(strip_spaces "$subject")=
=0A=0A			target_subject=3D$(git log -1 --format=3D'%s' "$sha")=0A			target_=
subject=3D$(strip_spaces "$target_subject")=0A=0A			# match with ellipses=
=0A			case "$subject" in=0A			*...)	subject=3D"${subject%...}"=0A				target=
_subject=3D"${target_subject:0:${#subject}}"=0A				;;=0A			...*)	subject=3D=
"${subject#...}"=0A				target_subject=3D"${target_subject: -${#subject}}"=
=0A				;;=0A			*\ ...\ *)=0A				s1=3D"${subject% ... *}"=0A				s2=3D"${subj=
ect#* ... }"=0A				subject=3D"$s1 $s2"=0A				t1=3D"${target_subject:0:${#s1=
}}"=0A				t2=3D"${target_subject: -${#s2}}"=0A				target_subject=3D"$t1 $t2=
"=0A				;;=0A			esac=0A			subject=3D$(strip_spaces "$subject")=0A			target_=
subject=3D$(strip_spaces "$target_subject")=0A=0A			if [ "$subject" !=3D "$=
{target_subject:0:${#subject}}" ]; then=0A				msg=3D"${msg:+${msg}${nl}}${t=
ab}${tab}- Subject does not match target commit subject${nl}${tab}${tab}  J=
ust use${nl}${tab}${tab}${tab}git log -1 --format=3D'Fixes: %h (\"%s\")'"=
=0A			fi=0A			lsha=3D$(cd "$Linus_tree" && git rev-parse -q --verify "$sha"=
)=0A			if [ -z "$lsha" ]; then=0A				count=3D$(git rev-list --count "$sha".=
=2E"$c")=0A				if [ "$count" -eq 0 ]; then=0A					msg=3D"${msg:+${msg}${nl}=
}${tab}${tab}- Target is not an ancestor of this commit"=0A				fi=0A			fi=
=0A=0A			if [ "$msg" ]; then=0A				printf '%s%s%s\n' "$commit_msg" "$fixes_=
msg" "$msg"=0A				commit_msg=3D''=0A				error=3D1=0A			fi=0A		done <<< "$fi=
xes_lines"=0A	done=0A=0A	if [ ${error} -eq 1 ] ; then=0A		exit 1=0A	fi=0A}=
=0A=0Agit_range=3D$1=0A=0Aif [ "${git_range}" =3D=3D "" ] ; then=0A	help=0A=
fi=0A=0Averify_fixes "${git_range}"=0Aexit 0=0A
--NT7Vp7lOswVCjS8Z--
