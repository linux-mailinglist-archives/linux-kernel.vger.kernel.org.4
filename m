Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5315FC7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJLPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47920A7AB4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C727F6153E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCDEC433D6;
        Wed, 12 Oct 2022 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665587183;
        bh=l4QcNmkxvk1IrzulV8Ga4EOMZ6Se2ic1mR58bl83hkE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g8F072n5cQz1Tr5cyfC2UD98sWYAFZo9lmb2mZ3Oq3aPMGhxnZGcp0bjIUeMpyjtt
         d7K1YXQhv9IDUQnlY5pQq+L8HJR1yxIoFstLA59z/8OsBBn3apnWXgvi9wPHngXrrQ
         SySDJA4DlDfonFSrB/qVzoU0vpNWei7acXHy3LR2neJw2bsJtaRrT0+S7CR9sXDkzO
         cK5NN72LwGQ6twa+I8DYQ2nMiX1Z/0rHp9rig7fP4YNhFi487qa8Or8XhGwUvbLaX0
         GGvyUTAzekNgYIwDoSFjeR8asEDdMx5sNS5m89LXE0qf4TX/lxtzfZcNd+YRgZWFzU
         OMEuFNXiCyQzQ==
Message-ID: <9cc1d42ab0495ff3f0113709966b47e8dab41266.camel@kernel.org>
Subject: Re: [PATCH v2 0/3] tracing: Fix synthetic event bug
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 12 Oct 2022 10:06:21 -0500
In-Reply-To: <20221012104055.421393330@goodmis.org>
References: <20221012104055.421393330@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2022-10-12 at 06:40 -0400, Steven Rostedt wrote:
>=20
> The follow commands caused a crash:
>=20
> =C2=A0 # cd /sys/kernel/tracing
> =C2=A0 # echo 's:open char file[]' > dynamic_events
> =C2=A0 # echo
> 'hist:keys=3Dcommon_pid:file=3Dfilename:onchange($file).trace(open,$file)
> ' > events/syscalls/sys_enter_openat/trigger'
> =C2=A0 # echo 1 > events/synthetic/open/enable
>=20
> BOOM!
>=20
> The problem is that the synthetic event field "char file[]" will read
> the value given to it as a string without any memory checks to make
> sure
> the address is valid. The above example will pass in the user space
> address and the sythetic event code will happily call strlen() on it
> and then strscpy() where either one will cause an oops when accessing
> user space addresses.
>=20
> Changes since v1:
> https://lore.kernel.org/all/20221011212501.773319898@goodmis.org/
>=20
> =C2=A0- Handle "(fault)" printing when there's a fault


Thanks for fixing the synthetic event string tracing bug, along with
the other nice cleanup.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>



>=20
> Steven Rostedt (Google) (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Move duplicate code of trace_kpro=
be/eprobe.c into
> header
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Add "(fault)" name injection to k=
ernel probes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Fix reading strings from syntheti=
c events
>=20
> ----
> =C2=A0kernel/trace/trace_eprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 60 ++------------------
> =C2=A0kernel/trace/trace_events_synth.c |=C2=A0 23 ++++++--
> =C2=A0kernel/trace/trace_kprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 60 ++------------------
> =C2=A0kernel/trace/trace_probe_kernel.h | 115
> ++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 142 insertions(+), 116 deletions(-)
> =C2=A0create mode 100644 kernel/trace/trace_probe_kernel.h

