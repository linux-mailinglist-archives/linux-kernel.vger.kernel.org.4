Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8FD662F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjAIScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjAISbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:31:43 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB77620C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY2U6W+n1ubaPGlp8RZxACN0MDJF+DS+DG8VaQ3eSk+8/5CjKQEwjNX3xccctI0qB1wyr9ijPat7dzlWX8daI8KveCS0LkrDL887qfjJp0nmG5qli7hTspPdETDPMME5/iA6WK0zbXWVXCTchbybaGyctRybIHWkAjZPcPH+0RsqoGyc71hRog/vk3Ka+ERw+HREDdXx/6O+90unILVzeYt3ZWJtfQZtGDc+cE8UlKcoFUnnCRGxujwwPuRPVdPvTbtbkEkftn74FZJDGVqZybG0VN7ZEeLxL4gnylFk2PuWJYp43l6kwoM11JDxD3DllVBKjzQ/VZI22zK2AvYQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EILYjBVO3TVH8Ko5wjRUBk5n4pb4VQ0+5EcJsTroldY=;
 b=cw0pz7bapB1x5b2tnwxJ7eIQfylFTTQw4un/oSasfYLApqC8e3pXho/0AEPHgzwN4Ns4NjOycLwJcQSalDNI9iZzrCBEpp6eHh9ZYQKbUZgTh/f1/s+sTPe7n0trvQTsbErhWLTYB1DEnfy25vtYQlhzKtSLM9wh2+cFVXy9sCeAhnjgZzLPyJaZH7fJ9wimal1MuYODJvsE3SIe2j2hHyDIQqL412uKsjwIOxU/M2g/sc6rUcbYCNh4d2Y5fNDchQyBuoTnqIHojcDoHv18+b/3IvOczOzgit4XDMAg8heutwi6/34nwX4qpTen1tSM3A7po1iW2WQrfdG7GTBJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EILYjBVO3TVH8Ko5wjRUBk5n4pb4VQ0+5EcJsTroldY=;
 b=JfO+sfhixC+W+fe0jtKhiG7i6ehSU2eYdkj+pXsdhIswSGiLgS3uG4IkYyDYeo/Z5tuf2T6W9C1w6dHa350uD/KY6gOfbz9eS1fRLOA5QR7m/2AkMEirVSst33W2FBS++zR3Itrl3/C8XxiGbURNvngcAd7jJY4cBRGw/CSs2q4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1324.namprd21.prod.outlook.com (2603:10b6:5:175::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 9 Jan
 2023 18:28:15 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%5]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 18:28:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Andrew Lutomirski <luto@kernel.org>,
        Jan Beulich <jbeulich@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Problem with pat_enable() and commit 72cbc8f04fe2
Thread-Topic: Problem with pat_enable() and commit 72cbc8f04fe2
Thread-Index: AdkkUwD6aRGwmsjgQS+RzXLKsHA1TA==
Date:   Mon, 9 Jan 2023 18:28:15 +0000
Message-ID: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=00dc8fc2-24d1-4fce-9fff-420171fb08f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-09T17:47:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1324:EE_
x-ms-office365-filtering-correlation-id: 4ea63db1-8ae9-4be2-2474-08daf26f45b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S0hSRZ3kks6ZlIjLxSNf+0y2KR2/w8sxlw3yukQtzfTPK43/V5HE/gMiw6emuN0VXD895iKbEVnljVYuPdrTszgmVzupCFn/hBWWtJw17H+dg5BdE7N4G7o28bN4AaPB3EyqYTXyxbE0ACUgO0vYEwnjW3bFkPa8mqpLQcIbm6/SQpb/lGH+TCCiyFWTYHyQexSD4MVC+Q47zfa1bd6CT65Iao9yVqUVkSbXFe8e5IQk09yc3JxtPnVwFA99BNTUddmK2J3Qu18bvj1N4Ef2bHYqyW53Cd9lHnlnPN8iE+PB2hksdb3lqOv9ljaw0V153UpMXuYMn2zQ4L+7bQHmKaH19p0TM/o2sMgQJE00uMpcwlMNOG1InZDt5Hfu9EmBWt14IOPGHCK3HmRDl4kpgStZQAhmpa7qhco44KVuqsYGGQfSiibWKNHQJ6pP5Tftn7GaQjmQ3oAiVqfVEBPYZaT+N41/Oo5ofVJXCjRQi45ayS4TG7kklFOSkRvVL1DVcLBZzEDmp/x+T9GrlpjWs0NjsRgM8VRCVpnNnn6n7Jlj0Qc/QsH0AQRIYFEku1ee5v+8shxBeUSvZJNgb2yd2/Lepg5kA+TyMrjEN2vANemJ+EazhTMWeoiSrpyiNbSYMeDQKS5IsOyOSy55L0V/h0Pue8klGp+XU3k1qp9f7qroZHZnZA91NgqJlfAUGT4i2Av1eGDY81D6zzoczi4jKK9BgnWSFVSyXW0X370tpqgtFxmMVyeuPkkPFi8rmcd1NxAQ3vK1IwVAkuPnWXbqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(9686003)(6506007)(186003)(55016003)(54906003)(82960400001)(82950400001)(86362001)(110136005)(66476007)(64756008)(8676002)(66556008)(38070700005)(66946007)(4326008)(76116006)(5660300002)(66446008)(38100700002)(122000001)(478600001)(2906002)(10290500003)(8936002)(26005)(71200400001)(52536014)(316002)(41300700001)(83380400001)(7696005)(8990500004)(33656002)(98903001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UhePUQmo4pcNB93+LJA+ab4VyqBcZaklXjsfTUWOpomAu3I5B0M/wl52B2wR?=
 =?us-ascii?Q?s/qtuxhJ/xnZf49/7phYJpUUxAFlwPlcRaITETyDK6t+AiTtQ5n6OEpGAEhE?=
 =?us-ascii?Q?EWWZMCwHeFFDfYcztLDTZ/OzStfRlnW/S9zJ+8VJ27rhj5h+nVld7MMyvsdG?=
 =?us-ascii?Q?ZTmQGy/xp9fq3csKrt4t9a7fTeAyrB1spJZn2K7G4j2i8SsXZHKPIMeYVc6Q?=
 =?us-ascii?Q?RaUwqhZF8ZsRvhPdvza3VNo5WtFLk9FWfRRtHWREd76YyDUzdmH0TqMHUYSn?=
 =?us-ascii?Q?UQXkTmJ7W/iPn/P1ndIs+USd5Mw3xrDMBVmmb/DbjlYuPZkOo0v85AMA0nzR?=
 =?us-ascii?Q?tM6gV3NmDkVp3SPGyP3GE6MM6oFOvnov+XBRFIVfGikGYYWWOwYfsJiJcJbD?=
 =?us-ascii?Q?bo26a8v0pacik7bfC7X4eoK0Z1bZt3omlFuS9toSZ5+2vsiFtbcXDmVPZtXv?=
 =?us-ascii?Q?/naKw2IL62GKSGrodlkTiH2hbcagie42PmJetCom7rl5jSpxhVVz8f5b1IDO?=
 =?us-ascii?Q?NsgABXc/bPQ7dXrXaKURNjmSLma1VlP+RjyCqvviXCbizA8TSauf8xkdvc15?=
 =?us-ascii?Q?50BtAr8EIOjHpMOq42wdk/2LNk+wQEK8HNvoJsGKhRxnWbclABt04O9vrClr?=
 =?us-ascii?Q?LjSattkauptquADmERxi7vc13TRa91aS8NBARPdaKUn5xrb0L5HAD4LJMqGc?=
 =?us-ascii?Q?nc66jguSh4hxolCWeExQeyjnmBXUwbDxOfZmZUG+P54s4jHo29oQiCL5P+r4?=
 =?us-ascii?Q?L9p7OHHJD/Dx4iLLoDO8LBzey5ETDp92u8F5rnij/lkIX3TP2s/c/i78Qvt2?=
 =?us-ascii?Q?XPh6EXJM/RnNaFxqWoHkmNcFw9mSUMg83U+DqtqvmiQncDRgyKzcCXxpq2MJ?=
 =?us-ascii?Q?DMCvLc6utWHmXbT7L9vr4Vbej1USWUSnxQX+s3ZLbu14eZuf+w1ozpfkw4T9?=
 =?us-ascii?Q?uTMOcCRvkVhdnoODt0uInIon22SwTI7gtCbKN4Xz/9IUSWmF8X0zrVl+7JG6?=
 =?us-ascii?Q?IugCcxe5xvT4rZqilo7TV+UXYAEi0UqFxMpz0aVj436Tnbv5IBlzsOVCKMyy?=
 =?us-ascii?Q?znP0rFaQDOkPaZRgm0LONdhsSpYd9OuRCmpsWmmr/tQahyPQgl/SU1B6rak9?=
 =?us-ascii?Q?pS1tjRrnMw4Xm6zl21pwInBuxAfNHLaJa0iSwpvQO118u7fkd5OhKWj8b70R?=
 =?us-ascii?Q?GPTLsicCow1vyh9rY7pcj4ruFhUEY9nThs0dtoL/fL3mva81mZEHDhwq8/f0?=
 =?us-ascii?Q?y5hujW2Fbhx5IJ/1xl6+U6TZ0LHKHFv5nkxEEroCRC0CVog281fk59CF/o12?=
 =?us-ascii?Q?UuQnSGjygytJ4B3u8Dp+8EJ/fWt4XVlBiLx5eVv/ItbrsWRFKIPrKRUAOcYM?=
 =?us-ascii?Q?aw9Z0spVvl27eBSfSfamj6ZqrL9CMp5SPdtrRwuZR/MYwRcZ14m5+gUnkRRD?=
 =?us-ascii?Q?4gH+UqKNuiRegGsCwej7bXsUJD1KL8AvRayFb9vwoH5VFYrVoYY6EP4WBJzj?=
 =?us-ascii?Q?ORsBj98VkV1mJCREzBHknGiZ6Ngc3VG8yo4pgE0XvZJB6VPvyRSifBDHxJQ3?=
 =?us-ascii?Q?WlphnwnTRpcHpEwrbXE2M/uGmw+Yf3J96IEnboCk1Svha8FBQoe69NVLEaq4?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea63db1-8ae9-4be2-2474-08daf26f45b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 18:28:15.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eK4J3fGSxNtkhQDYvymBtQasQIIX9wrGiCtwIydOXfwHy6ypllp5CWpp6v7+zD/nHxgxm1hm14XFlOdB0gW97SYjZfFz0yiQItTIIyHiK6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've come across a case with a VM running on Hyper-V that doesn't get
MTRRs, but the PAT is functional.  (This is a Confidential VM using
AMD's SEV-SNP encryption technology with the vTOM option.)  In this
case, the changes in commit 72cbc8f04fe2 ("x86/PAT: Have pat_enabled()
properly reflect state when running on Xen") apply.   pat_enabled() returns
"true", but the MTRRs are not enabled.

But with this commit, there's a problem.  Consider memremap() on a RAM
region, called with MEMREMAP_WB plus MEMREMAP_DEC as the 3rd
argument. Because of the request for a decrypted mapping,
arch_memremap_can_ram_remap() returns false, and a new mapping
must be created, which is appropriate.

The following call stack results:

  memremap()
  arch_memremap_wb()
  ioremap_cache()
  __ioremap_caller()
  memtype_reserve()  <--- pcm is _PAGE_CACHE_MODE_WB
  pat_x_mtrr_type()  <-- only called after commit 72cbc8f04fe2

pat_x_mtrr_type() returns _PAGE_CACHE_MODE_UC_MINUS because
mtrr_type_lookup() fails.  As a result, memremap() erroneously creates the
new mapping as uncached.   This uncached mapping is causing a significant
performance problem in certain Hyper-V Confidential VM configurations.

Any thoughts on resolving this?  Should memtype_reserve() be checking
both pat_enabled() *and* whether MTRRs are enabled before calling
pat_x_mtrr_type()?  Or does that defeat the purpose of commit
72cbc8f04fe2 in the Xen environment?

I'm also looking at how to avoid this combination in a Hyper-V Confidential
VM, but that doesn't address underlying the flaw.

Michael
