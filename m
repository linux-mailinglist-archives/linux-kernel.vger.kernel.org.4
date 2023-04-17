Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B847C6E46DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDQLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjDQLxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB01693C1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681732226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OBkSDRFjXrAi1Ti8Eq5HMQHqtg2NmT6RlyCWobY+Wg=;
        b=eGXAARowX4VNH8DDkACWp8+eeSlUOWbddN8pm5X+NNZE9XdU2BQ432RqWVXnDEOR9N/b9p
        lt87Ebo/8ZhzjebgBIYtD+6N3m+2u0GWJo58VpzhwK3A2moNF70V5IcTKyfUlz10/cQTQE
        MRWmlrUggLVytHvSls7i5Tx0IW16qT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-uRy5fGsKNrOszKoB_EfSQA-1; Mon, 17 Apr 2023 07:50:23 -0400
X-MC-Unique: uRy5fGsKNrOszKoB_EfSQA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6362B8996F9;
        Mon, 17 Apr 2023 11:50:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id E97CB492B03;
        Mon, 17 Apr 2023 11:50:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Apr 2023 13:50:12 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:50:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Sergei Zhirikov <sfzhi@yahoo.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Checking for support of ptrace(PTRACE_SEIZE,...) on older kernels
Message-ID: <20230417115009.GA906@redhat.com>
References: <997950238.3486335.1681414225118.ref@mail.yahoo.com>
 <997950238.3486335.1681414225118@mail.yahoo.com>
 <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, from https://man7.org/linux/man-pages/man2/ptrace.2.html

       ESRCH  The specified process does not exist, or is not currently
              being traced by the caller, or is not stopped (for
              requests that require a stopped tracee).

so if the kernel doesn't support PTRACE_SEIZE then ptrace(PTRACE_SEIZE)
should fail with -ESRCH as documented.

Perhaps this part

       EIO    request is invalid, or ...

can be improvef a bit to explain that this happens if the target is already
traced by us and stopped.

Oleg.

so in this case ptrace will fail with -ESRCH if called with an invalid requ=
est code

On 04/14, Alejandro Colomar wrote:
>
> Hi Sergei,
>=20
> On 4/13/23 21:30, Sergei Zhirikov wrote:
> > Hello,
> >=20
> > I've been studying the ptrace(2) man page and experimenting with ptrace=
() recently and came across this unexpected aspect of its behavior that I t=
hink would be good to have documented.
> >=20
> > I would like to use PTRACE_SEIZE in my project because of the advantage=
s it offers, but I would also like to support kernels older than 3.4 (where=
 it was fully introduced). My thinking was that I would call ptrace(PTRACE_=
SEIZE, ...) and if it fails with the appropriate error code indicating that=
 it's not supported I would fall back to PTRACE_ATTACH. That is where a lit=
tle surprise was waiting for me. According to the man page, ptrace will fai=
l with errno=3DEIO if called with an invalid request code. Logically, that =
was the error code I expected to get when PTRACE_SEIZE is not supported. In=
 reality I got ESRCH instead. In my attempts to make sense of it I had to r=
esort to reading the kernel source. Apparently, the logic in the kernel (=
=A0https://elixir.bootlin.com/linux/v3.0.101/source/kernel/ptrace.c#L944=A0=
) seems to assume that any request other than PTRACE_ATTACH must come for a=
n already existing tracee. So it proceeds to look for such a tracee (by cal=
ling ptrace_check_attach) before trying to interpret the request code. Obvi=
ously, in case of PTRACE_SEIZE, the target process/thread is not being trac=
ed yet, so ESRCH is returned. As far as I can tell by looking at the source=
 code, that will happen for any request code (with a couple of exceptions),=
 valid or otherwise. The relevant piece of logic seems to remain unchanged =
to this day, so this isn't just a problem with an ancient kernel that nobod=
y cares about. I am not sure whether this behavior is intentional (I would =
guess it's not), but in any case it's probably good to have it documented i=
n the man page.
>=20
> I've added some CCs.  Feel free to send a patch.
>=20
> Cheers,
> Alex
>=20
> >=20
> > Thanks and regards,
> > Sergei.
>=20
> --=20
> <http://www.alejandro-colomar.es/>
> GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5




