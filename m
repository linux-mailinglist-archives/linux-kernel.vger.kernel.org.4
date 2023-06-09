Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A672A21A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFISZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFISZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:25:41 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ABC35B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxLElXgy9ddw1ltYYN46WexmhTcT+Fvr/y9uYAMpYcjQ4eZ2/muVZyt2yOzXrIkVhYs71I0mZVqy8bBmpaP8SCiiLJIQYqaF5FtYhtgeUYhXi9KkWYBR4GQwypouHhlxfPXtWFJWa87kDUC2TR7yo5md+1p9Y69Ysdk9+t24iDsJiA5rhC5cebelTypZ00nyvsDqdxHqUI8kmu03VWvs//BF6uWKsSYbgveD7dO2SamMbVabGPIQQEVXSLwF33pdca3JokCY/xMAJZ1bNoamGRTP9Hs1NuCeS9otR41pqsnnsR7DCsgxPz1CWGl29xUkfWLNVWBEdby27HGUK/VFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqYXoVhc2coJCdBcdAI0cJ+WuWrucPdiVs1WdmeXYzo=;
 b=dz1bjq2g+B3to9aSVSfW+ldcolz/lm7bfmp4Lj8DytMwRyoq+rCrCaRqklErBXCY0Y/jttRtJjYlnuxBcKKj+HRIfhqrtDRPw/ZSrB+uzTDLv3vUsCocJfBWdcW+t2Irs2qhPUaMjwF9cfCgPOOuown6xA869oPqMWo7n+d0u95MSssf3Z3hB2yiUlxqGeiE9wx6JgbrmJBfxtLOG9mT3GhRzlavvgTV3a7iapnARgtDfZbib370ETdUrS0yQPemEteqOoUYsyUrH2L/HrdSAVKe4aXiL86f+TYNQ5AooJgFFayFuahYCzdnyaAwmih4muT9Smp15ldHOUGtoJQRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqYXoVhc2coJCdBcdAI0cJ+WuWrucPdiVs1WdmeXYzo=;
 b=JYFGftrZf+1Xeuco4nFMp7z6ZvheWVPftVklg+M0UIqIRXu6fJsGwyYsZz5E+fvUTnkC0uwWNYk103XfFIubHWYIzllr+tEWgGpAe/eODZ571KS7OHcKHnVdxPtDtk6es0k7xory+LGXQwl072OCGm2TECepxvLRvSQ5VeCMS4g=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH3PR05MB10075.namprd05.prod.outlook.com (2603:10b6:610:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 18:25:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a%6]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 18:25:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Juergen Gross <jgross@suse.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
Thread-Topic: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
Thread-Index: AQHZmrdK0cS1ZqzTfUGKvtxOsR4tqq+CyhcA
Date:   Fri, 9 Jun 2023 18:25:35 +0000
Message-ID: <1DF3CDEE-E9DF-4F16-B5DA-1727BBBC3C2D@vmware.com>
References: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
 <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CH3PR05MB10075:EE_
x-ms-office365-filtering-correlation-id: 2eaba6fe-7569-4258-8f71-08db6916eb3a
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0xqf58BFg3ToJnGUcOeXoWZN2EcUqY0UUJItVl29b+JDQ62eyVFszo7UUnl2vx6CXgMPmYXs1DuAD838q71vftm9RT66caIkoRAgzPSjYFMSdIh5AgEZZOTTE/ZJ1JTzLfyJ9U6iew0mC2/uaOApsodS1tFGA6otV02eyEhVQuQPMJUODl8bYozUZIwcW9Gy5BuNGGfwXbX43y/0T/fKSRqkNfOjnmTuO8LDDgcQ7lh7LRxpV2hNihvqyPPKW9H99N6/zCOw7gshS8gkTCl5eJ6k2P1Z9SqwBF+4OlqgaGv+FsCBlewfg663xRaVXDr2WISjiazP7jg3a5gwD2XD3qQug6TblFcC9dDC8zjDr9n29IOwYdseGpo0bK+Gr7UJ2G0+5S8ToinkNJd3AmaMOyCNl9ON5jjI512jDeILOqx5VeIMLy3YVfjXDFwEELT7qu0oyqze3iSEl+Bv4QifbKLWDxVhTRZYVnBbllF2KUCBIktf8LGk1hjZ4cSBbw+1UEBv2wH+Ud+M+Zu29C39l/QLs7PKJnC5yuyzxl9n8OxJ2yUQ3fgabYn5jy3EMR1yx4+ZuXlmn+TT/DiuTN/NPmy5TXn15gvjvGBYlvs7WGuSOcPC4jOXL3YoyX/vMtZRPqLtvRNHxPKSKswf8PYJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(6486002)(316002)(41300700001)(38070700005)(6512007)(186003)(53546011)(26005)(6506007)(7416002)(86362001)(2616005)(2906002)(33656002)(558084003)(122000001)(38100700002)(5660300002)(8936002)(36756003)(8676002)(66946007)(66476007)(66556008)(76116006)(478600001)(66446008)(54906003)(71200400001)(6916009)(4326008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gPBW4xEL1ACbCPcaGEovGcuY3M13YLkKA6Ofy9s0Y9nJkGZQlsLO3dxkl+CS?=
 =?us-ascii?Q?+NtMNCl0tQ1xmwJNvyfCZBLSgsTLtejDzXpu9IKolb8W7mTUz4LXiwv+nfVm?=
 =?us-ascii?Q?BXpUOxXZnNd1WkYlzr/ASTLaBW4AM0GB7jGhpRDpnj9xJSXrCCe8W6W/9FFD?=
 =?us-ascii?Q?DPaz2KXzbENqdxcZb/M8GDaw+aPYKaf9/WHrlejEdZ9vvRFmnhgo75i3tOom?=
 =?us-ascii?Q?xV8f1TTBg51Cvkzc9q84hK/090a0jGzFxt1EIpqjI+qJxNW7/ZqIBtTqVTt+?=
 =?us-ascii?Q?dYO4eHb6gYd2Byw/RyzROIWPR1ld7chSbX47upiQOC46SYyNyWspawvBd9x1?=
 =?us-ascii?Q?MWDj1nF2ba2cFP1yVFbskzU5lkfr727tWaAhsqhB2QYL5hbQVTXxfK+F4hwZ?=
 =?us-ascii?Q?1+Ab4fjH15OkQK8Figi0a3cEbNpeCc2S64rJ39Jm4tB25Ug4q8L2JicBYzd8?=
 =?us-ascii?Q?AhjZO01NcVD1l66f04ofmw+Q/ZOOwnEjo9DYCjAtNnE8KtmZywqVqgs0Q6au?=
 =?us-ascii?Q?qeXZ+hrfT6x6Z+mzraX9J0f9whHz7hgkEYe5Z+OgFaLD9YVXBrVJsplm9cMi?=
 =?us-ascii?Q?W40rPTuxMxCuseTSkJiauxnDOWno97L2JhbUTtpF1+IxxJXb6ip49GQt7GfH?=
 =?us-ascii?Q?2UNkcLlBPik0ftglAi2wkZ31FFHalo/4oGptgd5BtzUx0LqyZEAlbtp4PmMb?=
 =?us-ascii?Q?bqaacp3434Gc1lB0lsysmkbBnagAUtBeZSxwzmAtq3K5vP/B0f0xl4KEYlJz?=
 =?us-ascii?Q?ooEmNsGfgPfvVxc3rTlsfWnzfgWDs8ws9ky5y1KFL8SHp3pJVXkbLQCdtOXa?=
 =?us-ascii?Q?RmULJC/r0p8GLYzGv8dGPaLYI3/gO7eHA8kRDNUe2jfBDYu4obZQ+4JhFm0N?=
 =?us-ascii?Q?SH8LZEThzbkLaAbO51qv4HWcR/7be7UuEIqs88O1yKyj9LDbE2yGYV5Uduxo?=
 =?us-ascii?Q?6vXdk1I4XAfYP5TngE1zh/YEq4uavN3qe654sPXw80jGMPylQaiQXmQeE1Xy?=
 =?us-ascii?Q?WJrU6KFJUM7g0zvxvmrP099L8/X48YMiEs60KG47k50L9WwNQ4qsnvthNpO9?=
 =?us-ascii?Q?Tt75BL3uwiX5VZfUVJD7anUKfrpuH2uvl2N0Rh7f9CJwF1OedUz/bVWmo7tj?=
 =?us-ascii?Q?4wV/v5aW9z5rSSHhcDwpAxpdTwMohwx9p2r7w53OVzP1R1rSRTXy8mEn584V?=
 =?us-ascii?Q?YIO2AX9sqszwNnI3zX9h4+YeNHEObtEaUqGml/WcAODd9fHsLge1xxN7P5QJ?=
 =?us-ascii?Q?CSjDMcTC5THnT1nxYBhIiKVitC9VzErGFhyXpXVaas/pmw9z8h0ZPcjZD3Y6?=
 =?us-ascii?Q?3yNFPXger62Xd9w1nFDzHNTGfPIT2SQk6AyxmOuHEGylVjff+/Kjz9kNKb32?=
 =?us-ascii?Q?TdXSpCwuSr7qiXqRMqy2IUBmOd5ECCAaB61wyAVc5QGU2Nf8EchxpBVeZdAI?=
 =?us-ascii?Q?3OY6xIiASUJkIfvfImpif+KSa+bf4sxZq53RWFPeNAzszpw/ySYOZLNW5/1M?=
 =?us-ascii?Q?cDm5xsd0UA6FxbQXicfNSdpNxV+LHNUzdEL3ms/I48vxpSYPhNTbRjDu9d/P?=
 =?us-ascii?Q?YD3k7CVTaCf1LWZUw9jZL+C1bldZ01wm6Mufc1lj?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8AFCD4AC6F0B948A00DABDA354E9386@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaba6fe-7569-4258-8f71-08db6916eb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 18:25:35.9189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etZAr1twmoA7tF6Du2Oe2wTxYk/LMFu4txvbxBNIT/WCyy+uxafOuHeif29CfJKBvZwjNLnnaqSFTSLc2I7gEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 9, 2023, at 2:45 AM, Hou Wenlong <houwenlong.hwl@antgroup.com> wro=
te:
>=20
> Similar to struct alt_instr, make the struct paravirt_patch_site packed
> and get rid of all the .align directives. This could save 2 bytes for
> one entry on X86_64.

Thanks for taking care of it.

