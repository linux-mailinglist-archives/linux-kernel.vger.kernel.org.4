Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA47A6DE119
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDKQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430C4482
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681231038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPWp6r52L7J1jCPLtkvy2oQQJ4w+hLsPLUjw5MbCY3I=;
        b=BBv2QZ3XbD+qX1e2JT3u7zSNnyI0KzGD9RxmUwZnMUVMtnMFGFdzw9yKVDRAk35d53DmY0
        ZS0902U6elTioC1eBU6h2KR9V+qBNLOS2njBnIoWV5VVODkq1uqMG5gZquEfYZe89FJTRr
        9l2PQhJ8toxWwyWqR+2KGK/uEAX1jFk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-kcVPUHoGNG-luRWeIqszeQ-1; Tue, 11 Apr 2023 12:36:55 -0400
X-MC-Unique: kcVPUHoGNG-luRWeIqszeQ-1
Received: by mail-qt1-f197.google.com with SMTP id y5-20020a05622a004500b003e3979be6abso6659970qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPWp6r52L7J1jCPLtkvy2oQQJ4w+hLsPLUjw5MbCY3I=;
        b=D+CkhcIiuZCCnh9JArLPmr+xkAeRrv99q9c8Z8TaApqZeiaEkaGZ2U7EGver4MHUwP
         T7FR984MHLtMIbYsGIecXA61bXDRSvWYk+l6gL4E1r4PC2OhXYvTyi3MnqRJiQrTYw2v
         ouDW6dOpMErdcT2203k5mz84lB1OAet+RprEQ1j7tFOdBdbW+7m+I5rC0+t4IJn1EU0Y
         tw5lNMTo8AvCiZ34Ah7I/gQCUMK7w9wIALoEhBH9p8Sy52q0iQjHXig/XXv8cgKmp9a0
         wxOhMGowpPSrBOougMY9ll2n1jzgC3ZKtRsxm3WQlqs8VnAnwTDWUhmMS2gLaalRbza5
         1H9g==
X-Gm-Message-State: AAQBX9egrmMT6lsmqaK9OvRPJtNl90J7wXGa0y0VJ1IJ5RFVGjhiR8MR
        RFt3Rkn+U36G5TVxMg/rHpURee0ZpVN6gW7mFxIYgovNkZLKUixFWi6VaRhJiaHNzPIkxy5UWVl
        GTRcFBFSieLFwbEmoM2Yf2xlErGlvC+W2
X-Received: by 2002:ac8:5c4d:0:b0:3dc:d818:abb2 with SMTP id j13-20020ac85c4d000000b003dcd818abb2mr24678119qtj.17.1681231014676;
        Tue, 11 Apr 2023 09:36:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350adu1mKa2ego6uq/sF/lURptrzczwUn9JZi6H0YuWRWU7wSw7p8v5kCEaEGWc1h5Z2PCJh5Aw==
X-Received: by 2002:ac8:5c4d:0:b0:3dc:d818:abb2 with SMTP id j13-20020ac85c4d000000b003dcd818abb2mr24678087qtj.17.1681231014360;
        Tue, 11 Apr 2023 09:36:54 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id m10-20020ac866ca000000b003e6924c7e19sm2754737qtp.85.2023.04.11.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:36:53 -0700 (PDT)
Message-ID: <c638eff6a8ed4e41e520985c293d5c3ef88fb21e.camel@redhat.com>
Subject: Re: [PATCH v3 0/2] arch_topology: Pre-allocate cacheinfo from
 primary CPU
From:   Radu Rendec <rrendec@redhat.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 11 Apr 2023 12:36:52 -0400
In-Reply-To: <dea94484-797f-3034-7b86-6d88801c0d91@arm.com>
References: <20230406233926.1670094-1-rrendec@redhat.com>
         <dea94484-797f-3034-7b86-6d88801c0d91@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pierre,

On Tue, 2023-04-11 at 14:36 +0200, Pierre Gondois wrote:
> Hello Radu,
> Some additional points:
> 1-
> For the record, Will made a comment about adding weak functions
> (cf. https://lore.kernel.org/all/20230327121734.GB31342@willie-the-truck/=
)
> but I don't see how it could be done otherwise ...

In that comment, Will suggested using static inline functions in a
header. It would probably work but for the sake of consistency with
init_cache_level() I would argue it's better to use a weak function in
this particular case.

> 2-
> The patch-set needs to be rebased on top of v6.3-rc6,
> otherwise there is a merge conflict.

Fair enough. I worked off of linux-rt-devel for obvious reasons, and
forgot to rebase. It's a trivial conflict, which both "git rebase" and
"git am -3" can fix automatically. I will keep this in mind for v4.

> 3-
> When trying the patch-set on an ACPI platform with no PPTT, it seems that
> fetch_cache_info() is not called from init_cpu_topology() because
> parse_acpi_topology() returns an error code. This result in a
> 'sleeping function called from invalid context' message. The following ma=
de
> it work for me:
>=20
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -838,7 +838,6 @@ void __init init_cpu_topology(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't use partial information.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reset_cpu_topology();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cp=
u) {

Good catch! I think this calls for a dedicated patch in the series to
do just that and explain why the "return" statement is being removed.

> With 2 and 3 addressed:
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks again for reviewing these patches and for all your input!

> Also maybe wait for Sudeep to have a look before sending a v4,

Sure. Looking at other patches, he seems to respond pretty quickly, so
I'll wait until tomorrow and then send v4 if I don't hear back.

Best regards,
Radu

> On 4/7/23 01:39, Radu Rendec wrote:
> > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > tries to build the cacheinfo from the primary CPU prior to secondary
> > CPUs boot, if the DT/ACPI description contains cache information.
> > However, if such information is not present, it still reverts to the ol=
d
> > behavior, which allocates the cacheinfo memory on each secondary CPU. O=
n
> > RT kernels, this triggers a "BUG: sleeping function called from invalid
> > context" because the allocation is done before preemption is first
> > enabled on the secondary CPU.
> >=20
> > The solution is to add cache information to DT/ACPI, but at least on
> > arm64 systems this can be avoided by leveraging automatic detection
> > (through the CLIDR_EL1 register), which is already implemented but
> > currently doesn't work on RT kernels for the reason described above.
> >=20
> > This patch series attempts to enable automatic detection for RT kernels
> > when no DT/ACPI cache information is available, by pre-allocating
> > cacheinfo memory on the primary CPU.
> >=20
> > The first patch adds an architecture independent infrastructure that
> > allows architecture specific code to take an early guess at the number
> > of cache leaves of the secodary CPUs, while it runs in preemptible
> > context on the primary CPU. At the same time, it gives architecture
> > specific code the opportunity to go back later, while it runs on the
> > secondary CPU, and reallocate the cacheinfo memory if the initial guess
> > proves to be wrong.
> >=20
> > The second patch leverages the infrastructure implemented in the first
> > patch and enables early cache depth detection for arm64.
> >=20
> > The patch series is based on an RFC patch that was posted to the
> > linux-arm-kernel mailing list and discussed with a smaller audience:
> > https://lore.kernel.org/all/20230323224242.31142-1-rrendec@redhat.com/
> >=20
> > Changes to v2:
> > * Address minor coding style issue (unbalanced braces).
> > * Move cacheinfo reallocation logic from detect_cache_attributes() to a
> > =C2=A0=C2=A0 new function to improve code readability.
> > * Minor fix to cacheinfo reallocation logic to avoid a new detection of
> > =C2=A0=C2=A0 the cache level if/when detect_cache_attributes() is calle=
d again.
> >=20
> > Radu Rendec (2):
> > =C2=A0=C2=A0 cacheinfo: Add arch specific early level initializer
> > =C2=A0=C2=A0 cacheinfo: Add arm64 early level initializer implementatio=
n
> >=20
> > =C2=A0 arch/arm64/kernel/cacheinfo.c | 32 +++++++++++----
> > =C2=A0 drivers/base/cacheinfo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 75 ++++=
+++++++++++++++++++++----------
> > =C2=A0 include/linux/cacheinfo.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> > =C2=A0 3 files changed, 79 insertions(+), 30 deletions(-)
> >=20
>=20

