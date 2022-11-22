Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93F633EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiKVO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiKVO3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:29:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2138.outbound.protection.outlook.com [40.107.94.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16A63178;
        Tue, 22 Nov 2022 06:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVO5EiD11WQPItQWBm1kEG72FXkBo8C+Sl/3C6vlZ9zHVfUBZasNm9n8dVqMJFjUoQmAayqYbKJyrSBxaHD6fHaFkwqUAhWIrvMpA+kurIV8Hfvvy/BxURT6+T57XBxPuAt1AmnRomtMRaJpHXmR9DGsOUsgBjTukanTP3Z7eGRBAm30H19zmqjvjjood3U5EhcNwXTqkdeMlfOW9IunbaXRsmqGHNcosSUWFH3sQU48pLQGbSBO1g6kOKcaSTTTrR2VUWJuQiexjsGQJvYQ4QLtV/rERVPlByWmFmRntWRyg84vFk54fD4DORNoAxYuaaK84oHsWrm/9xquwUDozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO+/7uCdeOyNqk4favGQodR5qt+8Ovwsuj8MiIu8y+I=;
 b=A4qVIsqv3lUE1v8HvoZsz0t/XVOlPso0cnz3Wt5B9dVBfA/0X+sTdhj4TKlsdZo/bi3Z8l2bjaFFxetwgM1gSenpq7oy37y9Xydi24sh9OfBwSFGZ6Y6cjXFrFjiF1WYxCpBku0uxo0rBFdcEHBnwP37F1FPcNDlM3FLzqecptOj2aALEri6un4q7lsJ0dI216aiXc8SUvRsz+k61i171ETAm8YXkUZ4JIngMEt1hT68ha3HaVMRcA3t5yXGkuh65kgqSFQW35/bmN/EN2ok8BztUtiVc9OlG88X0/TqRRqK2rKMxf1XgHOkh+ob5HOQxQKu0/6M9jXL/lmo3mas7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO+/7uCdeOyNqk4favGQodR5qt+8Ovwsuj8MiIu8y+I=;
 b=H/3wqww6oN9fu9RN7DLgrMYUmbVfvbqc7sZyFj182QbxJx63Io4nKtsUaCEyLsMlC7Veg5fEYP9cM71jEgxjiwr4GdWr2r5w9Z/LMi4Kz8GWhfot8njQXhl+Lq91K5IiFJhvUeZiKi0xEX8dYALpAYY7nuARlOG5pscD3Z8isLA=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 14:28:58 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8728:282c:9d7f:6a9f]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8728:282c:9d7f:6a9f%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 14:28:58 +0000
From:   Varun Prakash <varun@chelsio.com>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        Nilesh Javali <njavali@marvell.com>, Wu Bo <wubo40@huawei.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: RE: [PATCH v2] cxgbi: move cxgbi_ddp_set_one_ppod to cxgb_ppm and
 remove its duplicate
Thread-Topic: [PATCH v2] cxgbi: move cxgbi_ddp_set_one_ppod to cxgb_ppm and
 remove its duplicate
Thread-Index: AQHY/Yd0U868INJv8EmLrpp5ykEXY65LAP7A
Date:   Tue, 22 Nov 2022 14:28:58 +0000
Message-ID: <BN9PR12MB532492F05C65D378ABF1DB5FBC0D9@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20221121083904.3824782-1-d-tatianin@yandex-team.ru>
In-Reply-To: <20221121083904.3824782-1-d-tatianin@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|DM6PR12MB4090:EE_
x-ms-office365-filtering-correlation-id: ee39c979-5c17-4c1d-fcf9-08dacc95e486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6eOjMZxuhRU2h+6TMYEDSCEi14gV3aj2qkC/1PSO62lpXaJKFMxZTUZFrNmU6p2Gm3kDQNK+SNDNEMeeNgV7cNx+BystKLO7diT1tyfvWwVtd1+8NEnC0QeUcwNT6JRLoPV2HUbFY3tCtD2r5dyv5hXS/SvczA6D4iW28VZTBfg/YUjSikgBQ5AKU10AkoYri+sRDzLeK4DiXRiL4TzjAhNg3P4+DRF8beISmiMTW80us1usWvwzCwM7qYTQxwvv1mUmIrSQJP5VCgrfDsLn+r2VDV7iXHHBrmacd02XiIi3jkm4WFl7ozxvQ2LieGsJZJLrqwAO7JCo9t3iyfXi2lG/1pExiI8s2CFsruO6wS5KuoQsYkNnAVPIRSFvSFzj7IHh9tH0+RqNB0M2rcmAjDhEX4D3JGQVuIc9ScFbqN9hCV6AJDZj5Ev0tywfr/+1sr9GKyWG8ozqA748R4WC4D01DweS1Ae2mWKzQw/klU61E6cnGbC4ZM3F9/rUtuOWTmWo12YbynJU3gV0TksginFJzAfv3Nvz7CcdIbrRQ0JgOmEO3OYgrFWY4OU6wfdzs85SmiQB4K0NZG6TPICfCHUp0QOw1H6VNfHBX4Ny1NKPejrBuIlqYk6cO0MSz2Xav6K9phxOpYmtrEVCos589r7tqonkkMgy4st/+bg2a4Cb8XbVo9SKC4AWvafEMFd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39830400003)(376002)(136003)(396003)(451199015)(66556008)(66446008)(9686003)(8676002)(76116006)(316002)(64756008)(66476007)(7696005)(66946007)(54906003)(4326008)(41300700001)(26005)(6916009)(55016003)(71200400001)(6506007)(52536014)(33656002)(4744005)(2906002)(38100700002)(122000001)(8936002)(186003)(478600001)(7416002)(38070700005)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xbQo91HqTjmPptLqAv2/qCjGBKEe51QnyCqzyyQ9GK8O9BCZfbcg5Gzecw+1?=
 =?us-ascii?Q?6g6prGi8m5ywrRWVf04yni1bM+6k+o/jgGdq5Ls8fSiO+ShnTNe6QoW4bO1p?=
 =?us-ascii?Q?rDxbk3DSUl0VS+pK4OPIlQYYlNeCBTxaLyaPsllYLQ3PVGMtTXntlVXkCAKD?=
 =?us-ascii?Q?e5tsi6QatEBZ5OA+xe2prd2FsqaD1y4zwXEZPh5L+dBK0ETYUFYQYnjWXPhS?=
 =?us-ascii?Q?juIHN7ZskfdMy8xcEvnhb1HcbcJgnS69xbIggQmUlqIrxFkVyihpEZWltvb5?=
 =?us-ascii?Q?pYuj/Wd3EOi+A5gyTgEOV+7mUEmI5srkcv41iH0C8gJWTxbyAKRpdJwiz4/B?=
 =?us-ascii?Q?fp1WGN6MSQLwSX46kPCykfQXg4kk1XvTJYC6KAorw87y6vKVo1u7j1efkxSD?=
 =?us-ascii?Q?ee9AcwZ3DqAGidzURNfs7f+++xpgwtJgf1GJ4azS66wvefyjBqqAdmIL4WwZ?=
 =?us-ascii?Q?BybxV88OWXifxCmmb1f0mPNf1fgaevE8BhGyAcChlRCmvTC+1FhO65jKzk7V?=
 =?us-ascii?Q?5nhiO8a/WfQJVBX46WoEQqlqbymh02hxejyK7D8pA6jJzc7zA2QESXC7m0Zu?=
 =?us-ascii?Q?tU+W6BQs8Gtk1aQ8xmUk7qGJ93SXNhyHp4apDdb4BOsOhfRtlRlQUJfEC/fh?=
 =?us-ascii?Q?vPOGuui5N2cv6I3QRVBMOQ+ETXnq7USUi+uOkUnKebYBoqoxIHlMxgF6v+kg?=
 =?us-ascii?Q?kadvAr+Xvsma36MUl2WIXVJxgmvE1fu8B8ldaI+rBCnuRfeX3xWMhjcvpz6t?=
 =?us-ascii?Q?ONUxE4Hod0EKRRRZXF/RC+7omPAUg4PS2kGMvkjMA+6EB682hJ0VFYW1uvLw?=
 =?us-ascii?Q?NDfWx3hrSew9jrgDHLdgc6AeDMCOuZAfRfEqf0XdvM7xeOkZFHr9pcjxIDHx?=
 =?us-ascii?Q?bzsPmau8EFeGpmEOz20QoSlAr2i1b2+8ET8V1gmsT4fOan2YHJXA8VHjJglq?=
 =?us-ascii?Q?/55IrRHCgxLGel9evpCGh0fjxuOoNtoGc/8cn6fCvxgeJuvS+/74ud0RxMxs?=
 =?us-ascii?Q?NMtmgzOvkrpyhIsqamZYy1IXnW19XJrovcmX3EB6pG4R5AhuFb65/Htwu6dt?=
 =?us-ascii?Q?tkNYnFE9oI/I7uYgZJWWhUn4jyKt/ap2ixaLR7v5A/VjCBnQfqDjEbnAqCEN?=
 =?us-ascii?Q?tdGdQZF7vmPcWKMWDRE2VvJCFWSm4uxeFwGEwBJemNCEDP6vBnT0qqhZQKPJ?=
 =?us-ascii?Q?O74XjILgu5Jw3Bwtmq954UnJdBzOgaWnSnU02SEDlq1mTbkmNF4vrC6XPtiA?=
 =?us-ascii?Q?4JH3wMzjiky6K8kk3XVTPbBTA4TKor7+kR9lMYBdwuRB9nLpBr0HCkgRjvr/?=
 =?us-ascii?Q?XYKL7dtezuZyOq3jGSmAy7Vb1+tiKJ2anaL+Xr0eCinzwljmNZW3jWBhVsF0?=
 =?us-ascii?Q?H3Tq+9gVjvy+D5PAPi7ack5PTUgekvYUQvLYKhmeDgnwa3mA/dLau98tAHsm?=
 =?us-ascii?Q?NDQk4B/e4VnyGzLlFZZWhGFxfByorlcS7hiA4hRoTbpfy0jRIJFebQ2cXFdE?=
 =?us-ascii?Q?SvuBaaDMSQwyY6EWR3uSBMsJ/w1V4ySxLnFMgh2ulI7Lv6WkdJNpUg0SUySh?=
 =?us-ascii?Q?FjCw4m8TfSMwX1n1jbhLi4NNpLxDJabD6Tye0nk0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39c979-5c17-4c1d-fcf9-08dacc95e486
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 14:28:58.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwR0/gWFy4zSlovQ+JWjxWpfYKV8k/cDRYdwtE9DKdu1zy3yPKVtgS76CEvJ2Uplu4ySbjl1PHpjbhOSzcZo/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>cxgbit and libcxgbi both used the exact same function but with slightly
>different names, and a missing NULL check in one case. Move the function
>to libcxgb/libcxgb_ppm.c and nuke the duplicate.
>
>This also renames the function to cxgbi_ppm_set_one_ppod so that it
>matches the rest of the functions in cxgb_ppm.
>
>Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>---

Acked-by: Varun Prakash <varun@chelsio.com>
