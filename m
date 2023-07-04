Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5682C74719E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGDMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGDMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:44:35 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673FE70
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:44:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso678781cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688474673; x=1691066673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46ITuGL3ZNdtf3XPTH191bqtT78mJQaPQAjnN2Ligrc=;
        b=G9dEsTYlJY7rrIhiJX2pO5eZFnteoP74190Ma/YYzlLB39KwGpPzOjSx4w4hiSkEMe
         +erhStJa5EZHzaz9gKQse3RgkDeifRHLOZ4n/mw8OMtOLMvMUKWY7GA9K+APnP+mGvO7
         +QswzMI8pHNUspASk45G0z5uvuTrUUC2LFXfHnIf+tI4B3Y4iBQwAPZIxozP55xUXtdg
         k9TM5VC0bf4dcjj30Wv3w62ybpyvc6VR/TLIYE1j3OSC2azAkc7ndbGuLQKHQZ/OapyH
         XC6ZJKwDxpZnYK5oN4UKzxzQdut7lLcste23KqrWF9HCcMRuxmjlzoh7K2L/JuPZ/Lv3
         sYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688474673; x=1691066673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46ITuGL3ZNdtf3XPTH191bqtT78mJQaPQAjnN2Ligrc=;
        b=lc98RIKhTX3mSr4c3O8KMdYSfGol3BiCfSV0R2hbaAwXG4MAutrzaSuQKAag2Yce8H
         QgJ2MJr/bssCGtql664ptZJbltGXBcsPfE7jXCrRqHCsyzREQLWbUaLxSRpE+IbqfcIb
         eN+NZWRLCDgbSbcIZMvV+j8BKvYyqNfia7WS6rbQdaYdyA8L/t25zjXm/zqFegMyYuYH
         thuWVsSV6/4ikzhiKvWwwUDkhgIr3KL3D7xdAPXhV1tvy+xgFtxICllUjj7KhMTWA+Al
         H+ZkRBETGI3BrYBLusXxENKtN3oA+x28+2Gmfs2g4bhnNGa76q/XJEv/+Te8c9OPCV8+
         IEsA==
X-Gm-Message-State: ABy/qLZVyE7njy9LKgpAayfsPwq0ryCl2BHjU9SaHaU2sgawAE2CdvQb
        hlSieU/DVUtCMLTFdvUN7XM2o3N+znhTswDuSaZMYg==
X-Google-Smtp-Source: APBJJlGi/if+3FWJlQjkWxchtte2XHbZnPbLiXlnFDF4GG64r5JEqeUrMPfPS4J29Epnh8YgtcEthsNmPpDPuntbz7c=
X-Received: by 2002:ac8:7f12:0:b0:3f8:5b2:aeee with SMTP id
 f18-20020ac87f12000000b003f805b2aeeemr111627qtk.22.1688474673336; Tue, 04 Jul
 2023 05:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230620033702.33344-1-tony.luck@intel.com> <20230620033702.33344-3-tony.luck@intel.com>
In-Reply-To: <20230620033702.33344-3-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 4 Jul 2023 14:44:22 +0200
Message-ID: <CALPaoChdFLTfA5g=vawTuOLk5T6dEkG79XXqm27shh-VeqNCOw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] resctrl2: Arch x86 modules for most of the legacy
 control/monitor functions
To:     Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, Jun 20, 2023 at 5:37=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
> +struct rmid {
> +       struct list_head        list;
> +       struct list_head        child_list;
> +       bool                    is_parent;
> +static void __rdt_rmid_read(void *info)
> +{
> +       struct rrmid_info *rr =3D info;
> +       unsigned long flags;
> +       struct rmid *cr, *r;
> +       struct mydomain *m;
> +       u64 chunks;
> +
> +       m =3D get_mydomain(rr->domain);
> +
> +       if (rr->event <=3D EV_LOC) {
> +               spin_lock_irqsave(&m->msr_lock, flags);

Will there ultimately be any locking at the filesystem layer? I recall
from feedback on my change adding a spinlock here[1] before that the
filesystem-layer locking took care of this.

> +               wrmsrl(MSR_IA32_QM_EVTSEL, (rr->rmid << 32) | rr->event);
> +               rdmsrl(MSR_IA32_QM_CTR, chunks);
> +       } else {
> +               chunks =3D 0;
> +       }
> +
> +       rr->chunks =3D adjust(m, rr->rmid, rr->event, chunks);
> +
> +       r =3D &rmid_array[rr->rmid];
> +       if (r->is_parent && !list_empty(&r->child_list)) {
> +               list_for_each_entry(cr, &r->child_list, child_list) {
> +                       u64 crmid =3D cr - rmid_array;
> +
> +                       if (rr->event <=3D EV_LOC) {
> +                               wrmsrl(MSR_IA32_QM_EVTSEL, (crmid << 32) =
| rr->event);
> +                               rdmsrl(MSR_IA32_QM_CTR, chunks);
> +                       } else {
> +                               chunks =3D 0;
> +                       }
> +
> +                       rr->chunks +=3D adjust(m, crmid, rr->event, chunk=
s);
> +               }
> +       }
> +
> +       if (rr->event <=3D EV_LOC)
> +               spin_unlock_irqrestore(&m->msr_lock, flags);
> +}
> +
> +u64 rdt_rmid_read(int domain_id, int rmid, int event)
> +{
> +       struct resctrl_domain *d;
> +       struct rrmid_info rr;
> +       struct mydomain *m;
> +
> +       list_for_each_entry(d, &monitor.domains, list)
> +               if (d->id =3D=3D domain_id)
> +                       goto found;
> +       return ~0ull;
> +found:
> +       m =3D get_mydomain(d);
> +
> +       rr.domain =3D d;
> +       rr.rmid =3D rmid;
> +       rr.event =3D event;
> +
> +       if (event <=3D EV_LOC)
> +               smp_call_function_any(&d->cpu_mask, __rdt_rmid_read, &rr,=
 1);
> +       else
> +               __rdt_rmid_read(&rr);

I like that the driver is responsible for deciding where IPIs need to
be sent, but it looks like the consequence is that RDT-level code
wants to add in the child monitors' event counts once executing within
the correct domain. The one-per-domain IPI assumption from the current
resctrl code being wrong is probably harder to overcome than needing
to figure out what additional RMIDs to read, but I'd really need to
know the synchronization requirements for __rdt_rmid_read() to inspect
the monitoring group hierarchy.

Would you continue to promise that the FS structure won't change
during a monitor read?  To us, the biggest priority for
parallelization is reading all the domain-group combinations in the
system, because we have a lot of them and want the tightest possible
snapshot of bandwidth usage, broken down by group.

Thanks!
-Peter

[1] https://lore.kernel.org/all/242db225-8ddc-968e-a754-6aaefd1b7da9@intel.=
com/
