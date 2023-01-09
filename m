Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CB6634DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjAIXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjAIXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:10:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231833BE80;
        Mon,  9 Jan 2023 15:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KidjC1BP2w/9BucawsVofB36TVWpziklgznuUVeQ1rQuTQSfyUYZlKMzsIn8y9LBGWPztvwuiKHaQs3rExKHsSIgZ092ctp1s3zOICW3u0B8oE2v0giEdDfYrfv5M1LxecHycfGUrFl1Zd++hl+iau2QapD9vZdEkB2BmcXzcQ3UraNZKQIpfMhV1Y9hj20NRe7oJA/QlJ9UlrhFZkDz9G0RKRzlgMIkqOcudTEjB2mzrPXBhadrpAiBW53+dFTA/d9oKhZ+CzOu2t9FKOrJtl9L68NHrBzxWA1SzQadyTBqhQOjYSKI+X5IiAduP/hORxHOg6uhSRmJylqF4ZdoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Qx6JEA9D52jk/yCp4ftOjVDzmJMLFupbI5xjm0zps=;
 b=nygnYxvblypkXCODiKSw7sGGSXoklzayG/XY2xXMrDV/6GOQJq3RTXf4yBudeer+43JuHI6dqPa3Ah9EiHrFOdkZtfRv8CnlNQ4tZuKA3J4n8gBq/zzr+SYugAq62RF1RKp+yppBr/9S5BjbNaWMgzFa/w0W7JLVLlYYsJaV+A1r90DG9xGGLLdqS4qIs73lkxlNgPSZvsBjMn6A3kRmQbYChFxjB4Av3Tbk327E0YBqcijXaVU+UrRNEKrCv+KI4Emaft2/NCsKmmAz00cMMeoMJeZEH8pWCAqqIrJkDthLPYf69TbDXwhBkD8Rz6iQHIrAyKj9IMBmYgoByUNwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4Qx6JEA9D52jk/yCp4ftOjVDzmJMLFupbI5xjm0zps=;
 b=YhySCTAimrMFEEP1zxbfFkEJ8WYuISBVjs2ntHvmig935O+hruzbzEuIaSRrcw2O4bq3omNVsw+mFcLn3WcGyRvy/SxYiMvar6uQ5zFCwSBX4OGo82cpZ2EZlLICpphFiMJP48GdHh9hfGcrkSP2Wn6g3Cpg4poAJnTcZegfNWs=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 23:10:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 23:10:40 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring
 Event Configuration feature flag
Thread-Index: AQHZJEmjhfzr9QeU50WxzksWMekCmK6WcBKAgAAOO4CAABXYAIAABRYA//+gtwCAAGaXgIAAEhqg
Date:   Mon, 9 Jan 2023 23:10:40 +0000
Message-ID: <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
In-Reply-To: <Y7yMbQ8hI9MGl1w3@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-09T22:56:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8a4692b2-8c32-427e-8dc6-8d017cae3c90;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-09T23:10:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: be66147f-91dc-4244-9887-6d107ad8d6a3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB8215:EE_
x-ms-office365-filtering-correlation-id: 3049368b-0c27-4dbf-0829-08daf296ba1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmFYuwrHum0sEsAwSZZjOBLmyktOp7qMRzk0lE03lpaKssfEhRzlz+pFDndNSFp//GwkbW5IRDdez1iU9OkAHp3aq4JAjQO3VMG1xCw2M7YMPwPOlTXgIaE6pegxnYNqw6jhzv1Tn6dMobte8G6tWDp3O1nuz5gy16ygpF0kAe3N7mXrTBUg1UOB+flM5NPkCWSLTa8zeJmNzGdXSljfvZxToGvhZv/iKU8EICS8XEh5efxlvpG5CILT3EK9vBP7pT0/XCZF4EIo8v19Jw6vlJNEkdAP/CehoVOBMHMXEzrM6NZTebNtzqORkaACZY8sgzCHxKBhGUNyS8BNnMB9/0gA5SNfV7W0A51xE5NZ8Oms2J7DFADZVdPIa0BBL38Zyg/eNOvddA/K3UNnRa6pcy8oomz9lC/SF0Q3gnkhnNze8nmwbrlQ0PQPN/8XuRFo7DAtiDmn++1CSn/vKAYj8beJ+UvPwKok7t+s6TewsIfb2jjf0mWuM3VVI0gxEUHNpqgMvjmQ8emNGFbkV8zJO0NcX116rop6XROQdu1F6piT5EWbjzanZSlZ9CB9zPsTrBUcXvJ78D0imU1Jb9Efn1FQNNmi5mURGUTW91QsGnHzqSMeD8hQO6K1TF3GhMREt06Bwuu207ujs9H9X50d9RrfRgBWi72F5o2JO/OlGzGlCscnuX9TmlfTN5Ze0pu8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(8936002)(2906002)(7406005)(5660300002)(52536014)(41300700001)(7416002)(71200400001)(38070700005)(66446008)(4326008)(7696005)(76116006)(6916009)(8676002)(64756008)(66476007)(66556008)(316002)(66946007)(54906003)(26005)(9686003)(122000001)(38100700002)(55016003)(86362001)(186003)(83380400001)(33656002)(478600001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wI0L6eMziL+ND3H4uJOEwrS+nyqQyhgzWctAHqk+t3uccPsDEDVLSwaDCVb?=
 =?us-ascii?Q?CrAL1waZanqeuwf4kHOzw6VkdKTYCCQ+iPVqct2QQplnXgASbGv0BK/aYvC1?=
 =?us-ascii?Q?1W/CdCaf91ALQFsXLDqm9Ve4WZrLHm6hZKFEoMJdWYVz2x/vHVEx3Nnx+LA1?=
 =?us-ascii?Q?zAmorkQJEP+tE4A6PcafFIXKGChj97lzaMjf6HGwmXVlLtI7Jod0d+q2cQyv?=
 =?us-ascii?Q?Vr3m4ge3XQc5Nm0oMt3iDz8O54foHODQfuLMg6OPqp/R/2AL2ZcfSy1lltsB?=
 =?us-ascii?Q?qXzQ5kMT0Lni+MxYFlERxMlrJ+70VLqDiQ5DQg6VVSUredh6wNnyl6yKgjA7?=
 =?us-ascii?Q?yN0f+sP4p6vJoVwEgN9xiJy5vhX1MK842JGxHOMnZTiXDoBKqqTT60QJH2zQ?=
 =?us-ascii?Q?+kl65JWdVL8wNIhmEO3CmWk5lUhOJmchJx4S8HxW4qPeGRRmLlO353v+vZnv?=
 =?us-ascii?Q?oLuuCvafpSuJEJs5cmevkwKXvrDvfJ5jSZw9QXySRl5QVrkBkBSVsSt9Tl5j?=
 =?us-ascii?Q?dBFDF+FxASxoQS0yGa58eK5MRzVH2//j2URVdP92jVmJgE3wxNN0mWAq24kP?=
 =?us-ascii?Q?lS/5a/AMP+93Vabm4Pv7jxLjcNwC4Bv1CoUy/1BdpA58QeFsibsVuqcr/XSp?=
 =?us-ascii?Q?nBRHFTxPLC/VzCCmjn9lmmwSeZb1hy5q7q3sjauIj9IWQPk6k1iCSzT66MPb?=
 =?us-ascii?Q?XKyLJVozZZ0mjmzKL8DxqONlF7ThGmOLRB1HxQye/VHwq1FXzAsOKz+JACNR?=
 =?us-ascii?Q?kronw3APy36WtmbUROmEs7fkwhhxt/JL0miU9oS1AMH+6/Qis6ZJDxCf4Ze8?=
 =?us-ascii?Q?Rcs65SN9r9VJVCy0guZ8SMqO96/vibvFTUCSJtLuruP3dtrHy3b+uiksBel7?=
 =?us-ascii?Q?UjStM5Su03L+HU4ajfypxE9hOEgHabRqSa1IkZs94B5F4v/EiayS6kDHRtaZ?=
 =?us-ascii?Q?qcmYR5yAk+SUn4mpIZaC5HbPxk01e3TpDijfwbw/2p++AuSEvwglkUWfnzYd?=
 =?us-ascii?Q?c/zzKqiqyEIzKe4sqLo/zYR7JS42MYNAGQtA8c7PZX0Edcoto+ii3o/HU5Bu?=
 =?us-ascii?Q?EZQGMQb/ygnz7EW1QfTHI/ODy+bJwWRZWhJl+yJ42MxsjR57sfHXqnwSwHKO?=
 =?us-ascii?Q?7pt8eTqNxjRvZqZKQVKL14tdeRXlWBbKG0hRMMc8hddsmIp5Sth+eEojBKVz?=
 =?us-ascii?Q?a8yr05JuhQmnf57J2mWtYgAZo2+u2It2vYUum6dPT9p80BU4UpYOKjCvGs/a?=
 =?us-ascii?Q?o2H13jKj1GCgSN3S41aHkOU8VhNHn6RAKldca+t5tgjksTQYs/FN9tTvjpZB?=
 =?us-ascii?Q?oCXUTaM0gtMzjhqakp5pQ8rNmrDqccvFM/M/dG58P4uX42tIcxauv6ZmXgNE?=
 =?us-ascii?Q?po9wjvG6O6qvr6lWOXPIzlaBzwsiVKDnrZ5dd9J2+37eQVdep6k51J4aHESr?=
 =?us-ascii?Q?Wp/j8vajzPo0j+4KSh++oQURTj4Mr5TVl7Ne4Rt//HKMkqWcRhFnAGRPzcyI?=
 =?us-ascii?Q?Ied+kszy5JZeo9jX0UE/rEUnSf7KmOWrv5VZ/PymPR9jDvunWCPAr+cniiHF?=
 =?us-ascii?Q?Ulc9r09RebP15bxWync=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3049368b-0c27-4dbf-0829-08daf296ba1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 23:10:40.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw0ElntDwGgr4zzQspwuZxD669XyVDC0JWFUW4NtpaSPXJMolPZtMWMkm9Z57sZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Monday, January 9, 2023 3:52 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: Luck, Tony <tony.luck@intel.com>; corbet@lwn.net; Chatre, Reinette
> <reinette.chatre@intel.com>; tglx@linutronix.de; mingo@redhat.com; Yu,
> Fenghua <fenghua.yu@intel.com>; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; paulmck@kernel.org; akpm@linux-
> foundation.org; quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com; Bae,
> Chang Seok <chang.seok.bae@intel.com>;
> pawan.kumar.gupta@linux.intel.com; jmattson@google.com;
> daniel.sneddon@linux.intel.com; Das1, Sandipan <Sandipan.Das@amd.com>;
> james.morse@arm.com; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; bagasdotme@gmail.com; Eranian, Stephane
> <eranian@google.com>; christophe.leroy@csgroup.eu; jarkko@kernel.org;
> Hunter, Adrian <adrian.hunter@intel.com>; quic_jiles@quicinc.com;
> peternewman@google.com
> Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring
> Event Configuration feature flag
>=20
> On Mon, Jan 09, 2023 at 03:44:30PM -0600, Moger, Babu wrote:
> > So, if we remove them, we need to update here also.
>=20
> We can "reroute" that documentation to /sys/fs/resctrl's info...

Yes. We could. But at this point we don't have all the features listed in /=
sys/fs/resctrl/info directory. We need to add all the resctrl feature bits =
in info directory.
How about we take this as separate task and I can send separate series to a=
ddress it?
Thanks
Babu
