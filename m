Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3B6FE898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjEKA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjEKA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:26:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F0558F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 17:26:30 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230511002626epoutp032f8248f3bdd64019a8b0f1ab423b4ab6~d7ycAfdsW0883908839epoutp03I
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:26:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230511002626epoutp032f8248f3bdd64019a8b0f1ab423b4ab6~d7ycAfdsW0883908839epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683764786;
        bh=anMEz2QucImTr7uBDxjHJeVZNcXrSgNZt0ct0sxAnw8=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ix8KFZSJpqVxvV2LR3RMvzus5ua8s7nfgTDPShvtNHiWDTg0Q2I340UYSxdTcDOj4
         6ynNsprWXOJT4vCDnKSa4C1J1wopuSn0EORetWYlh+g0YIyTFfgU6un3Q0meuL6+dJ
         37dfgwlTSYW4h8kuSQvVj2b6bhlmRmjGIoiM5O9M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230511002625epcas2p2ae8ce39b12618b84d08aa88e43ae39ac~d7ybTtfyZ2965229652epcas2p2F;
        Thu, 11 May 2023 00:26:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGt4100tpz4x9Q2; Thu, 11 May
        2023 00:26:25 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.9A.17293.0363C546; Thu, 11 May 2023 09:26:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230511002624epcas2p2de25beb7d136e1d983ad4f5dd436b546~d7yaLbbKL1896418964epcas2p2e;
        Thu, 11 May 2023 00:26:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230511002624epsmtrp118a5bdea9f791fdec231a372682e3b34~d7yaKOuC_0896508965epsmtrp1m;
        Thu, 11 May 2023 00:26:24 +0000 (GMT)
X-AuditID: b6c32a46-0c1eba800001438d-41-645c3630627e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.2A.27706.0363C546; Thu, 11 May 2023 09:26:24 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230511002624epsmtip16b1bdad732e5bd595caf9db22314ecb9~d7yZ65i7J0520905209epsmtip1Q;
        Thu, 11 May 2023 00:26:24 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <adrian.hunter@intel.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <bhoon95.kim@samsung.com>,
        <kwangwon.min@samsung.com>, <junwoo80.lee@samsung.com>
In-Reply-To: <60542301-e77f-ad26-e249-29d42f446d74@acm.org>
Subject: RE: [PATCH v2] ufs: poll pmc until another pa request is completed
Date:   Thu, 11 May 2023 09:26:24 +0900
Message-ID: <039b01d9839f$37cef8d0$a76cea70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQN1t83238AtSis63Xat9rXUxX7L4wHvqgOrAXsXcCusAGySUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmma6BWUyKweKvFhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLVYvfsBisejGNiaLXX+bmSy23tjJYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        ATpeSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCd8WPSNOaCq9IVU9u/MTcw3hbtYuTkkBAwkfg1Ywk7iC0ksINRovm7WBcjF5D9iVFi
        7ufjjBDON0aJVbe2scB0TDq1gBUisZdR4uvXkywQzktGic7+I4wgVWwC2hLTHu4GqxIRWMos
        8eRCK9gSTgFricsfnoPZwgLeEjsetDOB2CwCqhJfmjrB4rwClhJrDs9lhLAFJU7OfAK2mhlo
        6LKFr5khzlCQ+Pl0GStEXERidmcbUJwDaJmTxL2ZHCB7JQRucEhcX/uLCaLeReLA5Q1sELaw
        xKvjW9ghbCmJl/1t7CC9EgLZEnsWikGEKyQWT3sL9bGxxKxn7YwgJcwCmhLrd+lDVCtLHLkF
        dRifRMfhv1BDeCU62oQgGpUlfk2azAhhS0rMvHkHqsRDYuVbrwmMirOQfDgLyYezkHw1C2Ht
        AkaWVYxiqQXFuempxUYFRvCYTs7P3cQITtRabjsYp7z9oHeIkYmD8RCjBAezkgjv2yXRKUK8
        KYmVValF+fFFpTmpxYcYTYFhPpFZSjQ5H5gr8kriDU0sDUzMzAzNjUwNzJXEeaVtTyYLCaQn
        lqRmp6YWpBbB9DFxcEo1MJ1b1vMjeOf2LyvmTglev0P9l/cKncf5jywVTJV+1S39fjfPXPpt
        d07xq/Tbsx7sXfBO85iVbLjyDP+3iyaKSejM2S72xvzNJI6m/rS+M1zcU/Vzgus/O4ptD5jz
        JlRhZd/a60q5GW5L406tTr/8qXjTz4MKG18fX6WfLNddwcan3fvRzVU2l51j9sfMX9Y38mLj
        uo4/m75hnXXkUYa38rO2Xb/vtTvySGdKgfPhW0/fcP+ccyjwSWb961s753v6B0dIdGve3a98
        zLut6e26kxdCAuJ9F91dumh7aFx3m/OxokexjlUSS9XZmZNtTS6nOEnUf+Xq9nQ/+uTNquc/
        jpgsbHx9QORqm7yXotoLbwYlluKMREMt5qLiRACeVPSkXQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSnK6BWUyKwb61khYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLVYvfsBisejGNiaLXX+bmSy23tjJYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCI4rJJSc3JLEst0rdL4Mq49ewgS8E06Yp1L26yNzDOE+1i5OSQEDCRmHRqAWsXIxeH
        kMBuRomXb3+xQiQkJU7sfM4IYQtL3G85AlX0nFGi99Z6sASbgLbEtIe7wRIiAtuZJR5e/MkG
        UXWMUWL7uulgozgFrCUuf3jODmILC3hL7HjQzgRiswioSnxp6gSL8wpYSqw5PJcRwhaUODnz
        CQuIzQy0ofdhKyOMvWzha2aIkxQkfj5dxgoRF5GY3dkGFOcAusJJ4t5MjgmMQrOQTJqFZNIs
        JJNmIelewMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOEq1NHcwbl/1Qe8QIxMH
        4yFGCQ5mJRHet0uiU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
        ZeLglGpgMt/1KUAr4JHcKp2pktUm8z4efvlJx6Zr/6rF6sd3/pRrZLp0pLLK5ubWboVDUn4c
        cZM2xOdsrWXVeFsUm3Bmm9BG/1v/8uddEaiesv5Ye735kyKh7mePr915fnrj1PY/ukc3MoU+
        boz4uiGa66LmrW8J/z9cbeFbflxU+EFonohA8Jx9BeeeKrZlTT9w7vrfyB/pM/YbfVPacapl
        xfQ6jtiThXcW1BxN/mdbqXZ7n6/qw1cnXvK+uB2UoZN2cdqOKNuDRv9mV727NWduvuOX2Keh
        Ucekgx78149LmBB25ayy28Jq2c/qD2atu8xRsy7zcJJL+z3GDasfeTKFpPTtiP10b5n591un
        Fgvf5pnrODFBiaU4I9FQi7moOBEA9CAsBUEDAAA=
X-CMS-MailID: 20230511002624epcas2p2de25beb7d136e1d983ad4f5dd436b546
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230425012857epcas2p45eaa3f5f87de424bbf951b22653b3e70
References: <CGME20230425012857epcas2p45eaa3f5f87de424bbf951b22653b3e70@epcas2p4.samsung.com>
        <1682385635-43601-1-git-send-email-kwmad.kim@samsung.com>
        <60542301-e77f-ad26-e249-29d42f446d74@acm.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > =40=40 -4138,6 +4141,61 =40=40 int ufshcd_dme_get_attr(struct ufs_hba *=
hba, u32
> attr_sel,
> >   =7D
> >   EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
> >
> > +static int __ufshcd_poll_uic_pwr(struct ufs_hba *hba, struct
> uic_command *cmd,
> > +		struct completion *cnf)
>=20
> What does the name =22cnf=22 mean? To me it seems to be a weird name for =
a
> completion function pointer.

'cnf' is a term used in Unipro spec and I thought it's good to use terms in=
 the spec, especially in this file.
ufshcd.c is an implementation of UFS and its related specifications.

It's a notification meaning that UFS host's Unipro HW receives a UIC reques=
t from the host.
I guess maybe 'cnf' stands for 'confirm' but I thought 'confirm' look a lit=
tle bit abstract.

If you have an better idea of naming it, please let me know.

>=20
> > +=7B
> > +	unsigned long flags;
> > +	int ret;
> > +	ktime_t timeout;
> > +	u32 mode =3D cmd->argument3;
>=20
> Is my understanding correct that __ufshcd_send_uic_cmd() does not modify
> cmd->argument3? If so, why does this function copy cmd->argument3 and
> re-assign cmd->argument3?

This is for the case when unipro responds w/ busy(09h).
When IS.UCCS is enabled and is raised, UFS driver updates cmd->argumen3.
With this patch, it will go through the loop again w/ an unexpected value o=
f cmd->argumen3.

>=20
> > +	timeout =3D ktime_add_ms(ktime_get(), UIC_PA_RDY_TIMEOUT);
>=20
> =22deadline=22 is probably a better name for this variable than =22timeou=
t=22.
> Additionally, please consider using jiffies since I think that the
> accuracy of the jiffies counter is sufficient in this context.
>=20
> > +	do =7B
> > +		spin_lock_irqsave(hba->host->host_lock, flags);
> > +		hba->active_uic_cmd =3D NULL;
>=20
> Is my understanding correct that it is guaranteed that
> hba->active_uic_cmd is NULL here? If so, what is the purpose of the
> above statement?

Yeah, putting 'hba->active_uic_cmd =3D NULL' after wait_for_completion_time=
out looks natural.
But you can see there is one goto case w/ a UIC command not issued for UIC =
not ready, i.e. =21ufshcd_ready_for_uic_cmd.
To cover it together, 'hba->active_uic_cmd =3D NULL' has to be also put at =
the end of this function
and even wrapped w/ the spin lock. I wanted to reduce LOC and found a perio=
d already wrapped by the spin lock.
That is, it has the same result, I thought.

>=20
> > +		ret =3D __ufshcd_send_uic_cmd(hba, cmd, true);
> > +		spin_unlock_irqrestore(hba->host->host_lock, flags);
> > +		if (ret) =7B
> > +			dev_err(hba->dev,
> > +				=22pwr ctrl cmd 0x%x with mode 0x%x uic
> error %d=5Cn=22,
> > +				cmd->command, cmd->argument3, ret);
> > +			goto out;
> > +		=7D
> > +
> > +		/* This value is heuristic */
> > +		if (=21wait_for_completion_timeout(&cmd->done,
> > +		    msecs_to_jiffies(5))) =7B
>=20
> Please align msecs_to_jiffies(5) with the first argument (=22&cmd->done=
=22).
>=20
> > +			ret =3D -ETIMEDOUT;
> > +			dev_err(hba->dev,
> > +				=22pwr ctrl cmd 0x%x with mode 0x%x timeout=5Cn=22,
> > +				cmd->command, cmd->argument3);
> > +			if (cmd->cmd_active)
> > +				goto out;
> > +
> > +			dev_info(hba->dev, =22%s: pwr ctrl cmd has already been
> completed=5Cn=22, __func__);
> > +		=7D
> > +
> > +		/* retry for only busy cases */
>=20
> Please fix the word order in the above comment (for only -> only for)
>=20
> Thanks,
>=20
> Bart.=20

For others, let me change it.

Thanks.
Kiwoong Kim


