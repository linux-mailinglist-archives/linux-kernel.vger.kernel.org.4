Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7A65165B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiLSXD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiLSXCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:02:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB615F39
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671490858; x=1703026858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ECzHKD874L/2s+q5yE96TXJkBaCiaKo5Ubu4WxCLDKE=;
  b=VE3xVl5S59XHn3KF16mvBy3sfmdfe1ORCPcZkWPWRNv9ug8xCOkMRBv6
   AadahkMikCVw41rL4cXVwu9RTldpH9rUmX1VAsan0KgVAyqc46kPh9wvq
   A8DqoDgYPeT2Z7b9+bT6UWoPybvqDeV78b1sJ3kkw+nklgCTrkOSHo815
   nmW9dRZRU6/1Ud+YNZT+ckpvPeNAivITj6ReGZ5ONT/KOmqw+bzm0Wm51
   x8KRWYioNavcX1Mo6k6ncLXV509o1efOcaamWu53acpOIVIOHrNwpqeks
   GhVl+0YAI1RQjmbi1X78R+ItIt5l3lLw6EGR2XGh1B5lPvfsg3igrbFwh
   A==;
X-IronPort-AV: E=Sophos;i="5.96,257,1665417600"; 
   d="scan'208";a="219253138"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2022 07:00:49 +0800
IronPort-SDR: aDgS5hJdo+GCauJrnoG/6dc5v9y9ANaRnR3FIfzFKfqZ3dUCWfiTgoBwRQ84fqc3l9Ix86Yrnj
 4q1raowBcCiPo6zf+Wi6My6HZVpCURGDBvzRUMy8Lt5PmqGj9GWqFEoVhhJ7tITomxC2SYN/m7
 x99Uv79P5z8VMRhgs/M3TWYDuP2qFTsCEZ+c0U4wwKD9QCa3lBhuQDlN1eFepFjJHfF8T9Lc02
 ECSX9SzVC0gunVOleEwy7IwUGdI3OBHqI7udhMkZrNb6X/1xciXD9JNgjDAmeRssQJo71ZA2i+
 bg4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2022 14:13:19 -0800
IronPort-SDR: XsLIFWD0cT0HQcxLMrCvLZqT0Z62G31AtSYmatd4vIEB2Dg/gmti1Oe/krQz+Y+suGgyJW5qAO
 UvksgssOcOqp1Hg76tETXyI+xFW6FkAHvJj0SdmQ1OLDxj7VuBiaT+kCw7LcLkeUMYEgEXrL51
 sS04LdXXE415yt1X8GPAqDWsa5k/8q6/zClDHNdKDrQ/Dzg9X07khelxgm5m32f3IrGVlpadO0
 WLFh5ofwXVs5ssTa+udgiYHGxcXCb5MXVGHYEG+WchzovtilCjK9zsVaqeTcOyE8PuLcnARauR
 //I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2022 15:00:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NbZtm0Bkbz1Rx15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:00:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671490846; x=1674082847; bh=ECzHKD874L/2s+q5yE96TXJkBaCiaKo5Ubu
        4WxCLDKE=; b=me+2UvV2aY1MHUjEtnV2BXljahbxCr7z4uvHHA6KBbrnXDUez3d
        Oz6bUwywYmSFcCAa40sacJUC+8+Qmd8VFKYApHMx4Hq2zBnYWr+a8bsdXa0mFoGX
        Uij1pHUq7GkqTTE5Qm+7dJCSxb0S7+dwkW6sFseouLr1P+gqqtNnM8m3zCROE6h6
        0TfuJVBZc/mTGn9vog47jFRGHv+hh2A2MOTcgNXdPAPy5VhZgUb6V/G5EXRicHjt
        XaEwT1h+ghp4wDVhWWnHuK4Rsgo9NMWXL+7y6GzzX2KYFyygv6dCt6K1+vy5VwyQ
        RzkAak8uiNAHcoVAULf69ZljDCVEsKqYRRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QHYBFvrIVB5J for <linux-kernel@vger.kernel.org>;
        Mon, 19 Dec 2022 15:00:46 -0800 (PST)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NbZtj0MVHz1RvLy;
        Mon, 19 Dec 2022 15:00:44 -0800 (PST)
Message-ID: <4489f80f-9f39-8f3f-5d10-6b113131e65c@opensource.wdc.com>
Date:   Tue, 20 Dec 2022 08:00:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-ide@vger.kernel.org,
        hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
 <257dcd6c-2ffd-f518-9b13-c309348088d9@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <257dcd6c-2ffd-f518-9b13-c309348088d9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 00:55, John Garry wrote:
> On 19/12/2022 15:28, Jason Yan wrote:
>>>> +=C2=A0=C2=A0=C2=A0 if (test_bit(SAS_DEV_GONE, &dev->state) && dev_i=
s_sata(dev))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sas_ata_device_link_abor=
t(dev, false);
>>>
>>> Firstly, I think that there is a bug in sas_ata_device_link_abort() -=
>=20
>>> ata_link_abort() code in that the host lock in not grabbed, as the=20
>>> comment in ata_port_abort() mentions. Having said that, libsas had=20
>>> already some dodgy host locking usage - specifically dropping the loc=
k=20
>>> for the queuing path (that's something else to be fixed up ... I thin=
k=20
>>
>> Taking big locks in queuing path is not a good idea. This will bring=20
>> down performance.
>=20
> But it is expected that ata_qc_issue() should be called with that the=20
> host lock grabbed (and keep it).
>=20
> I think that the reason libsas drops the lock is because some LLDD=20
> queuecommand CBs calls task_done() in some error paths. If we kept the=20
> lock held, then we could have a deadlock, for example:
>=20
> sas_ata_qc_issue (has lock) -> lldd_execute_task() =3D=20
> pm8001_queue_command() -> task_done() =3D sas_ata_task_done() -> grab h=
ost=20
> lock =3D> deadlock.

That should be easily solvable using a workqueue for doing task_done(), n=
o ?

>=20
> Thanks,
> John

--=20
Damien Le Moal
Western Digital Research

