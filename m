Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB963CAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiK2WWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiK2WWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:22:21 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0252D6F367
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:22:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPx9JPyzAbNwgvmrsE5HIOI5gPyhPnmomEZyNiyo3DCzIEGdrqR/T8BwjowSUW3Qh/y5eKadJO7sFM3ln9oVgCHxIFnH0V3pT+5FJPk3f5DXdGUCyw+qA1FRGqQsvncSlJuowLpY74Eb9Uyi+dUcZDevX6iPcbXOt6IPclR3XQaF94ehjfYVgdGNbWsfgdXNWDlEkMB1m2qdcE7mXyIqbHlY8+zZhwtEqRu+j9zktnNSRI+95xYOXPpt00+nlm90c8GJGPn9vtuVv4tLiWwIRHWH3x53d3M7seEnxDlnU0Lw5hazR+mBD9Aie1ShoH930eL4lnUmm+OMxSrR1Atysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLcouwEriRKAEGMvPCNp6GujK6KvSsAJ0lAfb1XHrT4=;
 b=INSYQxMGI4UPhLHyV0pUwJOsZxRB2BqCjaKXfVo6ShlGr8XlmNZAzaBV3g8932rC4ZwIRkCnB8vd98xZGRG7qRiXWxEA9tMWHOhSNP+jIUJPkXEdUhZGYkFkHGMsaxjMhjBqrsm0ggu7i+k2L4hwii/KC6ICILOAfpI2k90bnJDPbaiLyvlIgPSnS8GqYYvZjWOdbbUcXTd3JxT+mnORfqVWbbjW+bJ1moYzgmFbmLYJdLK2YdTPt7mXhlKD7kRO3TKdF9jGZasofxoZ4eV4TpQAm56EvFEhIfj7LvCEyZDHp6YbJ5Rm+e63DPujjP1gwtzj/7IOnXSIVVbN821lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLcouwEriRKAEGMvPCNp6GujK6KvSsAJ0lAfb1XHrT4=;
 b=pJMRUkGtosaYLdCQuH5qja1uabfSMy/01XRd3h+pRPs4ieBL3S7OsbPhDi4VyQqZAqSz8OtyISFXmi0V4cAC1I9dLePdb6h9pFvuAjTFIdXByI2LXFXa27YaNDykW7d8Rl7ZHrUeb5pViX24QQsN2eL0dqEEe0W465fqoLH8Vdc=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by IA0PR05MB10095.namprd05.prod.outlook.com (2603:10b6:208:3dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Tue, 29 Nov
 2022 22:22:18 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1%7]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 22:22:17 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     George Kennedy <george.kennedy@oracle.com>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VMCI: check context->notify_page after call to
 get_user_pages_fast() to avoid GPF
Thread-Topic: [PATCH] VMCI: check context->notify_page after call to
 get_user_pages_fast() to avoid GPF
Thread-Index: AQHZA15ktwl6TZISUUOh1K630Cg8ja5We1eA
Date:   Tue, 29 Nov 2022 22:22:17 +0000
Message-ID: <6B18FBD3-2C2D-4C88-96D0-44BE3B4FDAB6@vmware.com>
References: <1669666705-24012-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1669666705-24012-1-git-send-email-george.kennedy@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|IA0PR05MB10095:EE_
x-ms-office365-filtering-correlation-id: c4cf34a9-c56e-4684-8649-08dad2582cde
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYClEwsyLZFW+H3Lb3GjMOelNLmKmeQGVA1A0MNcteZQYyH1wnDHukzAULUztaC393UZSJU7DieExyLC8mILUqSmzUIR+KMa0yHuOMXbORdEs5Tp/ZEq+9JT/iLOaxONmourciLcjbTagoRe5UuuQVAYmV3eojf1RiJoRm4fWz45PlhKGHgp1iNj8qLTwEKAI4L2UK1VK6z3bmZ4razXOSFhBtDOHvFFFtFLqC3Rlvjb1B9JUfsrjznTYOdwIYwAsKjjp2UU3aK01YlGgs0r2KVI4r7zLXTtEAtbCImjqoxJD0Lujf5ImrpwEJdsTWmLxuGjN2pCWkuust6DrNmn7B+CU6vPL43HpIFYSMjCbNtvHxQCCMG3lHbStMnAHAIfqm6mRY8ql6Ue8Yj6cgPEiYj8N98Li7tppT0/3dLlQxOZB0dr1fc6Ra6JFuYDgpqSvY+n7480yOtpd73cRn3YCTBvQgcjqPoKRqTExFyZ/M5fb9PlQ91EfzrocqC4j6bxJOYL8kyYe4qEEGE+rq6kZEB7AeHbWzqHusDal1V/WuZxBmrIsE8OKMgsPlcrhtpfuWKm6m8tQxHw0wUchTUVk67TIF4ivXLdVzi9qfJOeXr3teG0PNBA2//JuhWD6kw3eDdd3/jEIVmjoTnrabet/LdG1R03wBQiB5toxs6rM7j7Yjl8rQOY4DAZXUvHyXgAMmeZo/oSJJN4m2Z5zHtWx253dmMTGwZaRaDaaDEViE2Fvdy+4nOgkH1xJqXvBdSDSHwWf7UZBKf7TuKbLVaGXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(36756003)(83380400001)(2906002)(66446008)(66556008)(66476007)(8676002)(4326008)(64756008)(8936002)(5660300002)(41300700001)(186003)(2616005)(38070700005)(33656002)(86362001)(122000001)(38100700002)(66946007)(6506007)(6486002)(53546011)(316002)(6512007)(54906003)(6916009)(478600001)(71200400001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EIJS63sIwOtVPNIMEHIf5iqRtn/bGQ+jjkJLM7e74IsPCKAcmFrIbnOquykY?=
 =?us-ascii?Q?n9KGWpVeEEoOwDNAuVG46fxC41uxqLt86tAoOS6jA6i6fFMvuHGAODo6ecl/?=
 =?us-ascii?Q?Uv6s560Y3iy/70OXY8IOqv/dVEI8UfPcMRC7O6vsuBjgyTlsZ5KxOX63LesN?=
 =?us-ascii?Q?XCp+kh6YVJ78gIWqRpAnPQ/+wVzJgeF+2iWba4BlVm2OsrG1YT4APpgcdrX9?=
 =?us-ascii?Q?LddcTQ1WomPeH2huDNT9h/pHG2AlkaXSTDX/J1QD4lnr2txvy8sNWhbWPyaD?=
 =?us-ascii?Q?LiVMG/Nc6vtUtcM/2vs/HW4+uN6643HiR8D/G0WPvIPiEtWZl0MzXzmvzmbX?=
 =?us-ascii?Q?aXud4wNj+0YW93+UK5xiKoEyEeNU80SPxNET9Z5SDWFk9xUs9K2I/2/uKjgq?=
 =?us-ascii?Q?KzBo4FcTxTI3ioc4SoMPMc/Om2T+fiQTj9csR3HoF5DwsX6hXrDgVuFJKTgD?=
 =?us-ascii?Q?UCaezeEwPNjWBXbGlRcXevduKRiaweT7Fr2dDoDQ8SDqUYOcFBCU6ZqNkXxQ?=
 =?us-ascii?Q?A7J9H5xg9FEcb0uhMXJi6P7HLedt3k1mZbO8TGxV8o7GiFQRAuaynCnxxijr?=
 =?us-ascii?Q?dV9OvueL2J1W7n63etYhcHCgZf9/+kVvnX/l3JFR4pJs3LiAPx3Ju2rG6+3p?=
 =?us-ascii?Q?ldtkEXHxyF3hJXqWrLxSV5nbd6ZOSaYXt1PDKIv0RUm15gA2iYeX0tL3EFPC?=
 =?us-ascii?Q?PNEiELv2bWzHIMFbOQde+Ko4Gbib6qGGn9qV1Gi+dbWr7VTdQejaR5E1gnYt?=
 =?us-ascii?Q?WpkrpfxGimuK6Eg8yUb27DGR1eav5n21fN3jtiLNvNotD/JZN9V77up9XO5p?=
 =?us-ascii?Q?SjS/0xkSy/40Pwk+AChEqnoyD0v71g+vqx5Z4z2WELrW4Q7rrDk2D1h8smnz?=
 =?us-ascii?Q?fNde5878Jm61WdKRKnjaO8VIA11Qq+D6OGk5hxuQHqnw1TMWn+LQkdYyqA78?=
 =?us-ascii?Q?VUgkD9v08/TqSd4iJMbjw0TZKAPEDCyqarOydqsJdncknI6edeBJo4Zl+lvy?=
 =?us-ascii?Q?EKLltu19AN5mpHI2dKKUADcmE9qflQ1X1zbv22gft06R/F8EA7gVzKIvb9u/?=
 =?us-ascii?Q?hd/nQ9r9NQRAau3yuHc5cfAFi7FQq311SIpgmf4bUl5Xd+LhdKH7ZON3HAnM?=
 =?us-ascii?Q?2i0f7Gq69+zn5DpN/3yBQSwsF+dlO8PzkW+pbwqlIuAyAYn+ia7SD9p9s/5Q?=
 =?us-ascii?Q?P3sky8qUcbCc1gbZq0/e3bRm14lG+wGnIJvVggmA/h6NYLcZO2h//Og29bzb?=
 =?us-ascii?Q?+Vf37ORU7/hHtXmFK1Mn4s3L9x7mCAR3XINDIwVhmoaB/NL5bJStBQfg3H/j?=
 =?us-ascii?Q?oGzWXMLUBnRTkiAL/GP0ZVZgxGdTj7sFcIBfSwLxy/aXq+3biDWQs/eTP9su?=
 =?us-ascii?Q?+Jo10/R7Nr9EZ8+K5CZPonh17v9WCqrUEU/LVBisa2xARJOuO/oJHqhMesB8?=
 =?us-ascii?Q?JVsd5ORo1865eOweRJXvq8tVZvRCpAcZuXfW/E9PahjFsdTMamyBjovVWMB9?=
 =?us-ascii?Q?CbRXljIj24Ifn5SQy9Vj1BZe8R2RbUoYMbeks8nfZvxYcQTyuAklTHJuknvM?=
 =?us-ascii?Q?r+X/F0R2lAvO8WpoFqEuWa8VHaK1JWEThJt6to7qWi92chMUDzTN7p0MhDlW?=
 =?us-ascii?Q?ZtCL1K9KfR320Bw3nnNWxnW64Nd4z/oCHNLHkwSsftg8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09C908E94062BD419353D143B9D7CAC9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cf34a9-c56e-4684-8649-08dad2582cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 22:22:17.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W7O0vvt50pV7nrsitkSYHid+iTBANGryvzowMsH0HmNwKmbtpOtFzbQsrBr3RH8oBWKAHsYQHjBT5jzuN8AkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR05MB10095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 28, 2022, at 12:18 PM, George Kennedy <george.kennedy@oracle.com> =
wrote:
>=20
> The call to get_user_pages_fast() in vmci_host_setup_notify() can return
> NULL context->notify_page causing a GPF. To avoid GPF check if
> context->notify_page =3D=3D NULL and return error if so.
>=20
> general protection fault, probably for non-canonical address
>    0xe0009d1000000060: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0x0005088000000300-
>    0x0005088000000307]
> CPU: 2 PID: 26180 Comm: repro_34802241 Not tainted 6.1.0-rc4 #1
> Hardware name: Red Hat KVM, BIOS 1.15.0-2.module+el8.6.0 04/01/2014
> RIP: 0010:vmci_ctx_check_signal_notify+0x91/0xe0
> Call Trace:
> <TASK>
> vmci_host_unlocked_ioctl+0x362/0x1f40
> __x64_sys_ioctl+0x1a1/0x230
> do_syscall_64+0x3a/0x90
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Fixes: a1d88436d53a ("VMCI: Fix two UVA mapping bugs")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Thanks for the fix!

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>

> ---
> drivers/misc/vmw_vmci/vmci_host.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vm=
ci_host.c
> index da1e2a773823..857b9851402a 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -242,6 +242,8 @@ static int vmci_host_setup_notify(struct vmci_ctx *co=
ntext,
> 		context->notify_page =3D NULL;
> 		return VMCI_ERROR_GENERIC;
> 	}
> +	if (context->notify_page =3D=3D NULL)
> +		return VMCI_ERROR_UNAVAILABLE;
>=20
> 	/*
> 	 * Map the locked page and set up notify pointer.
> --=20
> 2.31.1
>=20

