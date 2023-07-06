Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9074A26F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGFQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGFQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:48:37 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D51BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAmm+DNMD8PbkpNQF8+eM0jRZvJhL+t4nE30SF9XyQGmBhTrrjFqGEu+tymgEWhOSLuxme7ZberjR1Kymffwy2KbeS32hsxHP41Svy8AYIh0n5E2uhBqbX/G3VN3bazPOET1Q98lmyqTFlEetWjXzkGMaA+7hbszzQ6/JPA9OYX3YnaHfhaNZ5+co8L+yQ0Fyi5ejH+WsTM1qG8cj0cUeSf7llqOa9UJdmEjecA+dHJbhevOmf8WnolsQ7453LiGb/UmXaO21rChTlzBcC0Sie9ikrAgyEfoJ9URDTCmwRAepvxnq0GoNXsUdLO8Xe7Q11X2y7wIebBzGbEyZxRIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QMUZZhnlywvb/2LLjIF0Dl3McYde8CTl84ZksRNIus=;
 b=ipK94dzd/UHGtqmhVCPLjzZ43vwZaLCJpE8NxPQkLiyvmtG8J2z8IhEkNgcwt/fWITgAwtWlzDJcpmBBksFIJW59ecxkKtz80kxiMone5jvC7IAXAd3o+ysWicBHk8gUQ/Tby4h1qbFm11f7bH45q7Mn5QMJm41rARLEUHxMniNpVC6DtxcnmyoMciN/iWm5EOuUFkuJlIV6oIMnl/RU+gd7B4zZ8Yz6te5A+wjW38MIrmAv3vve5COdB+RdcWmekaQnlHmR9nWETMzNwJhHjbqnWQp1u2b2IBGIxtakdEOYqXpcp2Oj4fS3Yk268j02jc6D8+kzUav4nESkle18ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QMUZZhnlywvb/2LLjIF0Dl3McYde8CTl84ZksRNIus=;
 b=DMz8+RFCNURsMLKh9fCFjZ5xfji6/vVPIsxNPy+9jtRN5+B9mobcq4NXzOePUUBxUxjCO1Y8LDc2t00JPuJbOETRcX2GyPqCR4OrIgACIPGMDH38crEPgjMwtPOEYB5ip8dbrXazR3r7OiBO8EkuBXJcFUFiPmkxrM8Cf7VvdDE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.10; Thu, 6 Jul
 2023 16:48:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6588.010; Thu, 6 Jul 2023
 16:48:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Topic: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1g
Date:   Thu, 6 Jul 2023 16:48:32 +0000
Message-ID: <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ad31c59d-51f4-4fd6-b617-852225f671c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T23:36:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3878:EE_
x-ms-office365-filtering-correlation-id: c6ed7d11-a73c-4596-eded-08db7e40d581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Kh9o0vT+GWIP/mk/sLT87jEKDfDU+i3DHhPEAZGnt4dmgT8fBqvuwjDC+k5KBL122GMDVzQ1FcLGPo0+FwKpyfGbwqO4/xAT7LOihCyRzC2soG9ms7TUBMIgp/bU/xHfoYTiPptb5xszDXV1g53FpEoqyZqRuKMT8Z/tkmBetwCFpfbhlaQ0qmfQ86vDWmba3jft3CgB6qySHHNfO/9LzKbZx5GWJHwKiwLPWr0/jGQweOx4PCFikIkup4kXnpIxa8LwMDK6+1s4D/QXpROkvU0IJm+Y3HQesXmfnER7ibDkSZHTmL7b5uGaES+eUdT6cSv+oy9leyio6rektilwBtwb7Cwx5PcqNJIU+7rY2PNOVcjh0WVsCfyt20z9L2hvz8Snn5tTfKaW2G09U24eZ8YaB4yV/PrXkA7+SFhChNFTJx9Fz6gdUTewWunZ1i9xwpF0TMzRTAlFQxbfkDb7BayWnAqC8vS+o74+PviOP0sw3+T6bBHHJJD7Np2VGMNWYw+Y3prPK3ynq2dIIRmrBYoiZGThcPSlba8T5Lx1rePOj2fsPyHYrlqQ5BdV6TfAIhb9ubgbyo0Lio+hfxhuiW3lKQ+dzAHgfztWZMW4rXBYStq/RHW9Wge4x/hc7NPPzMi5eGQHa1/NI9hQguHmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(66476007)(316002)(66946007)(76116006)(66446008)(64756008)(66556008)(38070700005)(4326008)(82950400001)(8990500004)(55016003)(6506007)(122000001)(82960400001)(9686003)(186003)(38100700002)(26005)(478600001)(966005)(71200400001)(7696005)(10290500003)(110136005)(54906003)(83380400001)(7416002)(8936002)(33656002)(5660300002)(2906002)(52536014)(86362001)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vd2QbI9DJXJjjgWsgn+AZwe4GscyCU1b4ylgvLpumREsl08I4K2f/o7RwGEg?=
 =?us-ascii?Q?G8reVEqWdIn2GHuJIH+jxjTy1/68VVYlCxLpO3vjBxUqmP2YcaEO7yEcHiMX?=
 =?us-ascii?Q?+P0VHYiHIdihjMciifU41jrzhCZPpYyvVyHKGehbir9foq1gtbASRcDJ8sgV?=
 =?us-ascii?Q?F2dkZ67STw1WbAgG8sbCWBMabkIMK+vJJZWW1jp4Sm0ESTBspbeX2iTPRJWU?=
 =?us-ascii?Q?iPyqiXCAnbIyAIgLMLrU8rLcSPardvRvEB2XUCN5fec8IcwsCvAcyxsdfkgU?=
 =?us-ascii?Q?8maMi7sy2Q2QcZ4+2JCld3lswuWAIg78N0CRgUbpBVam4bvlTZE8eQsmGhns?=
 =?us-ascii?Q?fZy34iVqlVtGrQ3mLxsyXZKXIkv15zyhO1fFpAW6xpCJoJ7DEcVsXfn9AjSj?=
 =?us-ascii?Q?TFw4DMsuT35Z8CUK3g7/GvrJ4xVBnk6cIFjW7mpFJSRh/JyxNQWgwyMxAfaX?=
 =?us-ascii?Q?NciorIMmKzIocgf3mya6pkX8MoMVuXDcMyji+sVMgLZ7KSYorYyhkqj29rbL?=
 =?us-ascii?Q?qLhK4Q8alykM0O1sMxIibIqaYBExlS1t9h+LnWgQJANdLCli2LQtPO22uss5?=
 =?us-ascii?Q?kNiJT6nxUxHYtnJv9kn3X+1qxFvWbZrI6+WyWTH1tcdb4KmbfILQx96IOPA4?=
 =?us-ascii?Q?morzXOZRjh6qGMIsD4mdbh+EKr14AZhGIy0OOd8yP0MkLtXihfQZiQ+3qQjX?=
 =?us-ascii?Q?gYsrVSNISMUd2XKUolPXQQ993dPDJ7tDDFoNomC9adBobfVkFfCr5/COnKKe?=
 =?us-ascii?Q?GJqWKDDFofl6vUBabU3okyEMmzEB5xJR9ntCE4X/zqP+/P8+SKVA4YA+h9EN?=
 =?us-ascii?Q?r7jmnip646dY1bFEdlOmgKjXWUToxM91MzFq4tRFOEk58qofw4cpfYC+O8SI?=
 =?us-ascii?Q?7hy0j6Dt98gRwQPRZxicqju7ijzWLtMaDeZTyDgf57Wswy7DsVpIhHDWcPKX?=
 =?us-ascii?Q?vvd+qFhCuM8M/l/LUuETtN14JLnQeHJKoK28RGOCWVz/lGcxAVrhhwXQzMqt?=
 =?us-ascii?Q?rYSTD3ydWFPzxLwwZr9oSq2/EGYHgcsutBjINw1aLPvVBzyAwcu1w04KnZBy?=
 =?us-ascii?Q?8FBBNKbXk/scPYRu+k+POg2jUN5Y/XzV/30+gxrE6RkKYkasKaImb0u6/TBo?=
 =?us-ascii?Q?Vk1OwPOBTSB2lHM4NPNwWEX3QCHL+6dG15NwCCX/LayCPd7SuLM0+ZDnDATx?=
 =?us-ascii?Q?RIW7G2BUre8hAjAtA6fHnsabJmC5DNFGLVMJX0IXw2QY1p0gLRoeOJPowxvc?=
 =?us-ascii?Q?IMlP7vzFSAt59P4K9x/Ji2IU5+0Lx4T4NugUIrCpUlgkKwn1yGHNEE/h9QDk?=
 =?us-ascii?Q?ykHey5UEs9XwVoVPXPwyfqjeOn7Uw7Ei+u36JFPO6G4BgEvMe18BO5azSe3B?=
 =?us-ascii?Q?BIf3nsn4EJEsHf6TQbjFWLgrQIhBoa+czzPaShnZ0iYuKmo4Zuzg77zCqmEt?=
 =?us-ascii?Q?4bkogFW2sYijbw6z9yIopx0uLdb8I3OVNoBHN+xgjOoi0In/yTENMKiEBkAX?=
 =?us-ascii?Q?EzOXh4HyYyd4/5OdTh4dvBGzM1YGvKPXcbF+w3XVUFGZxbRogQasEmdI0rBF?=
 =?us-ascii?Q?PitIfdc4XLGWPnnd4rWwJ1XFTXAlAVMSG7TVPoGkAG8IOhkkGif4UV+X1QCz?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed7d11-a73c-4596-eded-08db7e40d581
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:48:32.7524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFUqi0q0TYHYofOzAW7q+UBG41N5ImZ6UCbjRS0CGrScXNPN+RGrPpGp/XtDXBX55rTP3SwevkTKlqMlfPd4rNTAisJ548HSNrm8m0jtITA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, J=
une 6, 2023 2:56 AM
>=20
> During review of TDX guests on Hyper-V patchset Dave pointed to the
> potential race between changing page private/shared status and
> load_unaligned_zeropad().
>=20
> Fix the issue.
>=20
> v3:
>  - Fix grammar;
>  - Add Sathya's Reviewed-bys;
> v2:
>  - Add more info in commit message of the first patch.
>  - Move enc_status_change_finish_noop() into a separate patch.
>  - Fix typo in commit message and comment.
>=20
> Kirill A. Shutemov (3):
>   x86/mm: Allow guest.enc_status_change_prepare() to fail
>   x86/tdx: Fix race between set_memory_encrypted() and
>     load_unaligned_zeropad()
>   x86/mm: Fix enc_status_change_finish_noop()
>=20
>  arch/x86/coco/tdx/tdx.c         | 64 +++++++++++++++++++++++++++++++--
>  arch/x86/include/asm/x86_init.h |  2 +-
>  arch/x86/kernel/x86_init.c      |  4 +--
>  arch/x86/mm/mem_encrypt_amd.c   |  4 ++-
>  arch/x86/mm/pat/set_memory.c    |  3 +-
>  5 files changed, 69 insertions(+), 8 deletions(-)
>=20
> --
> 2.39.3

These fixes notwithstanding, load_unaligned_zeropad() is not handled
properly in a TDX VM.  The problem was introduced with commit
c4e34dd99f2e, which moved the fixup code to function
ex_handler_zeropad().  This new function does a verification against
fault_addr, and the verification always fails because fault_addr is zero.
The call sequence is:

exc_virtualization_exception()
ve_raise_fault()
gp_try_fixup_and_notify()  <-- always passes 0 as fault_addr
fixup_exception()
ex_handler_zeropad()

The validation of fault_addr could probably be removed since
such validation wasn't there prior to c4e34dd99f2e.  But before
going down that path, I want to propose a different top-level
solution to the interaction between load_unaligned_zeropad()
and CoCo VM page transitions between private and shared.

When a page is transitioning, the caller can and should ensure
that it is not being accessed during the transition.  But we have
the load_unaligned_zeropad() wildcard.   So do the following for
the transition sequence in __set_memory_enc_pgtable():

1.  Remove aliasing mappings
2.  Remove the PRESENT bit from the PTEs of all transitioning pages
3.  Flush the TLB globally
4.  Flush the data cache if needed
5.  Set/clear the encryption attribute as appropriate
6.  Notify the hypervisor of the page status change
7.  Add back the PRESENT bit

With this approach, load_unaligned_zeropad() just takes the
normal page-fault-based fixup path if it touches a page that is
transitioning.  As a result, load_unaligned_zeropad() and CoCo
VM page transitioning are completely decoupled.  We don't
need to handle architecture-specific CoCo VM exceptions and
fix things up.

I've posted an RFC PATCH that implements this approach [1],
and tested on TDX VMs and SEV-SNP VMs in vTOM mode.
The RFC PATCH has more details on the benefits and
implications.  Follow-up discussion should probably be done
on that email thread.

Michael

[1] https://lore.kernel.org/lkml/1688661719-60329-1-git-send-email-mikelley=
@microsoft.com/T/#u
