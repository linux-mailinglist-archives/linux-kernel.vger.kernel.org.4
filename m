Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804246EB35F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjDUVJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDUVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:09:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB83B3;
        Fri, 21 Apr 2023 14:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciZH5okcRBrjM7hAs+TzUQmG4hZuDM07esocgkjEQtOwR1zI1Lr8R/hHu7ybpr/tmgh1TvVudbY//RnlDLypDCXypz1ZdENY7XpLKNgY3iEPPF1l2mCdi6haisQqkYG6JssCOAychWd/WEc1raqypBzLOatyzOnYtAnoU9Ro1OBXkikVpaA+NbWe7uJHpbWvyTPOJebmvhmYM+WOGtHWMJ4qcLysMw4ad+rg8AEo5bQBhqBXGxjnxekxzwqeyasvIRV+FJ9KAOhJWhxHk6HEcpl2w04JKRrYR11BCCBtgtqg9cwBZ0yVcEcwY/4CPAnEy4gxbN8Dp/5v7PHNFXQnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4RF9OSqdSHUdYtqseGMYOAdwsqXnDXhpojnwpi3clA=;
 b=H1dc0f2py8mdDjJQPBSjJrRFtP2FM2INPYMOjyw4Os/e1Uey/wEuoIkV4FiBAGDXre8FOm5qukD4L2sb6LjSkkAcXszOqkwYqDHzWeVAtRLkpkYVNZr4N5WQZ5FdZVHlakSKA/1B6JvOuK3KJ9BfmwcNjkn7wDdZOaHFAQg99Qi59HITj2lLekWkNmpOSPMjJSPb5izW6DEw7vdznziEUF9qKKBTczDZ07XHeaBfCDNiPbVFaAjh6lTusIcS/5F+y8KTrh3vkTPeEPg2iZIs0RY902zXRZu/GQ7urjFfq5PW0mJLwG7DAgWPFxk+khZUxLs80uS778y8uBjcezQoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4RF9OSqdSHUdYtqseGMYOAdwsqXnDXhpojnwpi3clA=;
 b=nLPWLUPrK0Q+DRCgbkZJjdXhb62abSVj0AP44EEpvxLNjur87PLzmksoAWVh2ulmwjV6uDH/pqBxulAKCVf0bau2GAYghvXYb1xZUJ/cX/u3WBolX/sIs6K8oFF8o+EuaNDf6lzVphnWRglJvD9D4KKH/63dPnaUlWxPD8vkxJQ=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 21:09:44 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::adb5:84df:8e81:3689]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::adb5:84df:8e81:3689%3]) with mapi id 15.20.6319.021; Fri, 21 Apr 2023
 21:09:44 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     "Bilbao, Carlos" <Carlos.Bilbao@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Giani, Dhaval" <Dhaval.Giani@amd.com>,
        "Day, Michael" <Michael.Day@amd.com>,
        "Paluri, PavanKumar (Pavan Kumar)" <PavanKumar.Paluri@amd.com>,
        "Lal, Reshma" <Reshma.Lal@amd.com>,
        "Powell, Jeremy" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "seanjc@google.com" <seanjc@google.com>,
        "security@kernel.org" <security@kernel.org>,
        "Bilbao, Carlos" <Carlos.Bilbao@amd.com>
Subject: RE: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Topic: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Index: AQHZYLcEfJ6b20h0hkuXNIoWahRCDq82ZJ+Q
Date:   Fri, 21 Apr 2023 21:09:43 +0000
Message-ID: <SN6PR12MB270262FCDB71ABF5303A125894609@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
In-Reply-To: <20230327141816.2648615-1-carlos.bilbao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b8cd44b2-847a-426d-928a-3f3dfd10d26e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T20:51:20Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|IA0PR12MB7579:EE_
x-ms-office365-filtering-correlation-id: dbbbd1dc-e571-4839-4fa8-08db42acbae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qJVYRaM0cI/zl3T5YXEFEWSLRS50uNBAIUivuEp4FNxVxa+v95B9hEiwMTQ/8+uVDf855Ac3ezh6qEUZAruRKo0AvO7WGemal16Dw4dySCazZAEKcU0O5eFaO9QJlKR0njuAqDVT4UwH2lqfca/Tntr8nNvH9bT8Y46XykU2ILj2bQNFqX1CWfYLN4LAzaznCtNrBI1YLN75I7D+TTstAYYYPvWPmuG0XHDctOPzbHAjKUNqOfSjqSAXgvcX3kNl7+B//007kGbuwycYYd+NLuhfxfqwn2R42S6Fk9b5+wNl6Air3iglKNmQxwVuXqUWCbyTgIkBPx5wh/3HH8E/IqC6Pg9sw1OQlVi7khaUD+wE0RKsIvMG1kds0taUXy7oprWQUQGVrasUmwqNHMNIQP9MmNbZZviRmgCSjmRjd7V7RqANE0qtY6hxE8KCVLWOgSkKkDL0hXFzBzw+p2tj6Yc8QJz8OpQhpWPNh1WK9L5oXsH7g1g6KFdwpUxMUz8O4rxpJoAF9i8L3JwTMY6XjeJRDYAHi2HQSGSGAYdH2ZU7ft6akLMPLcwdp0wQ40YLACGJDvujhZ/JHnKOCis+MuSQ7HWG8UI0lg6xyonvW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(316002)(4326008)(64756008)(966005)(66556008)(66946007)(83380400001)(7696005)(71200400001)(76116006)(478600001)(54906003)(8936002)(66446008)(38100700002)(110136005)(41300700001)(8676002)(122000001)(66476007)(15650500001)(2906002)(30864003)(52536014)(5660300002)(38070700005)(7416002)(7406005)(53546011)(6506007)(26005)(9686003)(186003)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4o+pOlXYpIrO4c7vbzNNm65jO7X5kqAqGD+pGRwoRUFdoW7bz5Z3trTIkx+u?=
 =?us-ascii?Q?tWZZmypr1lpwF1p1g6sqeBSBi4n+1n6d2H5nGj3j99V71zOxaXXqI5Lx9JNi?=
 =?us-ascii?Q?zKJKeT4Fx5BuMcs+SU0wf344+WNUbT7mUVaEDegb3pmoohCR11rK6VLc++Ry?=
 =?us-ascii?Q?k67hdcZG30zOkQ0gKQsIFh5kOxaKXL76+DDr7iA016MLSY0sugi9WL96aHDv?=
 =?us-ascii?Q?HKtzuJ8EWScEB4oGrdT1DaPP5qVgaSxe79OqCTMH1yRi0ftqLy6YQqm++RSE?=
 =?us-ascii?Q?v+a6kUvVwGe6T920dyYRCYq6jMmMSCQTinPssWAqhOL7KE7bb4dIC70R5awW?=
 =?us-ascii?Q?HHV0lTmgmzwGt0TAOEU5wslnvUE4SYJ/9FH6S5yUd/WM/g7ckPCCIxK+I2dZ?=
 =?us-ascii?Q?qascrc49jwXukOVrfYPvgTcJCerWmFU0oGxJ0snfZK4RHeIi2phxC9hfan0v?=
 =?us-ascii?Q?LN6AFLXhqzcdtEVnEXkRgt+anmfL7qkv8L8gyTXvW1JPE+xXTD/3FbEvheGa?=
 =?us-ascii?Q?2GjThyVO/2Lmd6sN2Di+G/SoTEWy1YznF/lGpolv3+sBtNMLOFgmqN1KkFv3?=
 =?us-ascii?Q?Ohq5M6r3in+NexYfgyR2+EPVfPtAJXHNk7Bp+gDI4TtCSeS5FKzcxn6hG11Y?=
 =?us-ascii?Q?qEz77ql9k7JcuG7wUbYtPKMD3pZgLMmglvLnDoC9cyFdJBx+HshW9BTHQqTI?=
 =?us-ascii?Q?j9ZvPIBe1yon1mIOUaTMTDHskdmp+4o2EYNaovhPS8KDai4uKr6tovOZI3I5?=
 =?us-ascii?Q?xb+qflASq6rFH0vf9uNMh71IDu8xx9ZsZmi4sPCdNpwAZaJLkwVdBT8OJRXd?=
 =?us-ascii?Q?sHjeZKFo5tBtGUvyv+EHAw/tYe3S3kC2HfppIwGI2Wh/8NsqJJeZuUp1bvSe?=
 =?us-ascii?Q?4GARcg6TxCvFHpof76EfPVO8ZMETdTam5ri6FII9WKOsmk9wc3Xz3mx9NOv7?=
 =?us-ascii?Q?JcaC2qHD2NtAU6OIY5VQLe8uTq18+QojaXF8RmNDhAJJ4gL0sJmeeig1SfaJ?=
 =?us-ascii?Q?rF2csqQ2iCNaaYBRCCat1pMsB7uirai8gUwyEpiCM4dxPZdGdVnTfgIUDMxm?=
 =?us-ascii?Q?HoyydrHrHCJ5/Je5ZaLtUF4nuEyFttfOfarTuM6UjGiDck7A+vfBPmMGmRB1?=
 =?us-ascii?Q?Ne3k6AZXCjCCbgz0ok9EfIH6RUlHtj4+8Rj+zIs7kNo9Sf3e/M27tGPf4ekA?=
 =?us-ascii?Q?f5EIqoUjgeO9tT795GiK4mCIucZf+wukxCLmGNqrvvG9axxrOY/o9Ry0TrO/?=
 =?us-ascii?Q?59v72mPlgvKzjm7kFzpvUPgYWBfZCQKlKc1RyN8p4tK5CFyhjkoKo1OFV+q8?=
 =?us-ascii?Q?x6JEiltQPZdWSMXxmoD0V+laJfuK5Icn5EGBeeg2WL22x+9Yq3VNbqP8zeZ3?=
 =?us-ascii?Q?seWL9WV1eDmYdxKNf/Iud2uNR72Zz5KBN1lMtPsVlShCefSrzWFKaaQdXsJm?=
 =?us-ascii?Q?WefsOkrnALyFWcXn2ZOkkdtCopwXnMgIHOplYQFiGG8JRaMAlZuD/Skyrw/K?=
 =?us-ascii?Q?TedMwWotiJ537Aub4NsRceEjkVxrms0efIBeekS36nzCqhTK+Nmzk9dj7Z1D?=
 =?us-ascii?Q?4QREvA2bOgV7JdAWjqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbbd1dc-e571-4839-4fa8-08db42acbae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 21:09:44.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y18o9UAirglgNBPhltTFvYFDz1QjQl2nUMEpqkYmvXPJxRsVjNU+vbqL9uDc4A3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Carlos Bilbao <carlos.bilbao@amd.com>
> Sent: Monday, March 27, 2023 9:18 AM
> To: corbet@lwn.net
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> ardb@kernel.org; kraxel@redhat.com; dovmurik@linux.ibm.com;
> elena.reshetova@intel.com; dave.hansen@linux.intel.com; Giani, Dhaval
> <Dhaval.Giani@amd.com>; Day, Michael <Michael.Day@amd.com>; Paluri,
> PavanKumar (Pavan Kumar) <PavanKumar.Paluri@amd.com>; Kaplan, David
> <David.Kaplan@amd.com>; Lal, Reshma <Reshma.Lal@amd.com>; Powell,
> Jeremy <Jeremy.Powell@amd.com>;
> sathyanarayanan.kuppuswamy@linux.intel.com;
> alexander.shishkin@linux.intel.com; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; tglx@linutronix.de; dgilbert@redhat.com;
> gregkh@linuxfoundation.org; dinechin@redhat.com; linux-
> coco@lists.linux.dev; berrange@redhat.com; mst@redhat.com;
> tytso@mit.edu; jikos@kernel.org; joro@8bytes.org; leon@kernel.org;
> richard.weinberger@gmail.com; lukas@wunner.de; jejb@linux.ibm.com;
> cdupontd@redhat.com; jasowang@redhat.com; sameo@rivosinc.com;
> bp@alien8.de; seanjc@google.com; security@kernel.org; Bilbao, Carlos
> <Carlos.Bilbao@amd.com>
> Subject: [PATCH] docs: security: Confidential computing intro and threat
> model
>
> Kernel developers working on confidential computing operate under a set o=
f
> assumptions regarding the Linux kernel threat model that differ from the
> traditional view. In order to effectively engage with the linux-coco mail=
ing list
> and contribute to ongoing kernel efforts, one must have a thorough
> familiarity with these concepts. Add a concise, architecture-agnostic
> introduction and threat model to provide a reference for ongoing design
> discussions and to help developers gain a foundational understanding of t=
he
> subject.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../security/confidential-computing.rst       | 245 ++++++++++++++++++
>  Documentation/security/index.rst              |   1 +
>  MAINTAINERS                                   |   6 +
>  3 files changed, 252 insertions(+)
>  create mode 100644 Documentation/security/confidential-computing.rst
>
> diff --git a/Documentation/security/confidential-computing.rst
> b/Documentation/security/confidential-computing.rst
> new file mode 100644
> index 000000000000..98439ef7ff9f
> --- /dev/null
> +++ b/Documentation/security/confidential-computing.rst
> @@ -0,0 +1,245 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +Confidential Computing in Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +.. contents:: :local:
> +
> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao
> +<carlos.bilbao@amd.com>
> +
> +Motivation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel developers working on confidential computing for the cloud
> +operate under a set of assumptions regarding the Linux kernel threat
> +model that differ from the traditional view. In order to effectively
> +engage with the linux-coco mailing list and contribute to its
> +initiatives, one must have a thorough familiarity with these concepts.
> +This document provides a concise, architecture-agnostic introduction to
> +help developers gain a foundational understanding of the subject.
> +
> +Overview and terminology
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
> +virtualization technologies that allow Cloud Service Providers (CSPs)
> +to provide stronger security guarantees to their clients (usually
> +referred to as tenants) by excluding all the CSP's infrastructure and
> +SW out of the tenant's Trusted Computing Base (TCB).
> +
> +While the concrete implementation details differ between technologies,
> +all of these mechanisms provide increased confidentiality and integrity
> +of CoCo guest memory and execution state (vCPU registers), more tightly
> +controlled guest interrupt injection, as well as some additional
> +mechanisms to control guest-host page mapping. More details on the
> +x86-specific solutions can be found in :doc:`Intel Trust Domain
> +Extensions (TDX) </x86/tdx>` and :doc:`AMD Memory Encryption
> +</x86/amd-memory-encryption>`.
> +
> +The basic CoCo layout includes the host, guest, the interfaces that
> +communicate guest and host, a platform capable of supporting CoCo, and
> +an intermediary between the guest virtual machine (VM) and the
> +underlying platform that acts as security manager::
> +
> +    +-------------------+      +-----------------------+
> +    | CoCo guest VM     |<---->|                       |
> +    +-------------------+      |                       |
> +      | Interfaces |           | CoCo security manager |
> +    +-------------------+      |                       |
> +    | Host VMM          |<---->|                       |
> +    +-------------------+      |                       |
> +                               |                       |
> +    +--------------------+     |                       |
> +    | CoCo platform      |<--->|                       |
> +    +--------------------+     +-----------------------+
> +
> +The specific details of the CoCo intermediary vastly diverge between
> +technologies, so much so that in some cases it will be HW and in others
> +SW.
> +
> +Existing Linux kernel threat model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The components of the current Linux kernel threat model are::
> +
> +     +-----------------------+      +-------------------+
> +     |                       |<---->| Userspace         |
> +     |                       |      +-------------------+
> +     |   External attack     |         | Interfaces |
> +     |       vectors         |      +-------------------+
> +     |                       |<---->| Linux Kernel      |
> +     |                       |      +-------------------+
> +     +-----------------------+      +-------------------+
> +                                    | Bootloader/BIOS   |
> +                                    +-------------------+
> +                                    +-------------------+
> +                                    | HW platform       |
> +                                    +-------------------+
> +
> +The existing Linux kernel threat model typically assumes execution on a
> +trusted HW platform with all of the firmware and bootloaders included
> +on its TCB. The primary attacker resides in the userspace and all of
> +the data coming from there is generally considered untrusted, unless
> +userspace is privileged enough to perform trusted actions. In addition,
> +external attackers are typically considered, including those with
> +access to enabled external networks (e.g. Ethernet, Wireless,
> +Bluetooth), exposed hardware interfaces (e.g. USB, Thunderbolt), and
> +the ability to modify the contents of disks offline.
> +
> +Confidential Computing threat model and security objectives
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D
> +
> +Confidential Cloud Computing adds a new type of attacker to the above li=
st:
> +an untrusted and potentially malicious host. This can be viewed as a
> +more powerful type of external attacker, as it resides locally on the
> +same physical machine, in contrast to a remote network attacker, and
> +has control over the guest kernel communication with most of the HW::
> +
> +                                 +------------------------+
> +                                 |    CoCo guest VM       |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->|  | Userspace         | |
> +   |                       |     |  +-------------------+ |
> +   |   External attack     |     |     | Interfaces |     |
> +   |       vectors         |     |  +-------------------+ |
> +   |                       |<--->|  | Linux Kernel      | |
> +   |                       |     |  +-------------------+ |
> +   +-----------------------+     |  +-------------------+ |
> +                                 |  | Bootloader/BIOS   | |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->+------------------------+
> +   |                       |          | Interfaces |
> +   |                       |     +------------------------+
> +   |     CoCo security     |<--->|   Host VMM             |
> +   |      manager          |     +------------------------+
> +   |                       |     +------------------------+
> +   |                       |<--->|   CoCo platform        |
> +   +-----------------------+     +------------------------+
> +
> +While the traditional hypervisor has unlimited access to guest data and
> +can leverage this access to attack the guest, the CoCo systems mitigate
> +such attacks by adding security features like guest data
> +confidentiality and integrity protection. This threat model assumes
> +that those features are available and intact.
> +
> +The **Linux kernel CoCo security objectives** can be summarized as
> follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest private memo=
ry.
> +2. Prevent privileged escalation from a host into a CoCo guest Linux ker=
nel.
> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.
> +
> +The host retains full control over the CoCo guest resources and can
> +deny access to them at any time. Because of this, the host Denial of
> +Service
> +(DoS) attacks against CoCo guests are beyond the scope of this threat
> +model.
> +
> +The **Linux CoCo attack surface** is any interface exposed from a CoCo
> +guest Linux kernel towards an untrusted host that is not covered by the
> +CoCo technology SW/HW protections. This includes any possible
> +side-channels, as well as transient execution side channels. Examples
> +of explicit (not side-channel) interfaces include accesses to port I/O,
> +MMIO and DMA interfaces, access to PCI configuration space,
> +VMM-specific hypercalls, access to shared memory pages, interrupts
> +allowed to be injected to the guest kernel by the host, as well as CoCo
> +technology specific hypercalls. Additionally, the host in a CoCo system
> +typically controls the process of creating a CoCo guest: it has a
> +method to load into a guest the firmware and bootloader images, the
> +kernel image together with the kernel command line. All of this data
> +should also be considered untrusted until its integrity and authenticity=
 is
> established.
> +
> +The table below shows a threat matrix for the CoCo guest Linux kernel
> +with the potential mitigation strategies. The matrix refers to
> +CoCo-specific versions of the guest, host and platform.
> +
> +.. list-table:: CoCo Linux guest kernel threat matrix
> +   :widths: auto
> +   :align: center
> +   :header-rows: 1
> +
> +   * - Threat name
> +     - Threat description
> +     - Mitigation strategy
> +
> +   * - Guest malicious configuration
> +     - A malicious host modifies one of the following guest's
> +       configuration:
> +
> +       1. Guest firmware or bootloader
> +
> +       2. Guest kernel or module binaries
> +
> +       3. Guest command line parameters
> +
> +       This allows the host to break the integrity of the code running
> +       inside a CoCo guest and violate the CoCo security objectives.
> +     - The integrity of the guest's configuration passed via untrusted h=
ost
> +       must be ensured by methods such as remote attestation and signing=
.
> +       This should be largely transparent to the guest kernel and would
> +       allow it to assume a trusted state at the time of boot.
> +
> +   * - CoCo guest data attacks
> +     - A malicious host retains full control of the CoCo guest's data
> +       in-transit between the guest and the host-managed physical or
> +       virtual devices. This allows any attack against confidentiality,
> +       integrity or freshness of such data.
> +     - The CoCo guest is responsible for ensuring the confidentiality,
> +       integrity and freshness of such data using well-established
> +       security mechanisms. For example, for any guest external network
> +       communications that are passed via the untrusted host, an end-to-=
end
> +       secure session must be established between a guest and a trusted
> +       remote endpoint using well-known protocols such as TLS.
> +       This requirement also applies to protection of the guest's disk
> +       image.
> +
> +   * - Malformed runtime input
> +     - A malicious host injects malformed input via any communication
> +       interface used by guest's kernel code. If the code is not prepare=
d
> +       to handle this input correctly, this can result in a host --> gue=
st
> +       kernel privilege escalation. This includes classical side-channel
> +       and/or transient execution attack vectors.
> +     - The attestation or signing process cannot help to mitigate this
> +       threat since this input is highly dynamic. Instead, a different s=
et
> +       of mechanisms is required:
> +
> +       1. *Limit the exposed attack surface*. Whenever possible, disable
> +       complex kernel features and device drivers (not required for gues=
t
> +       operation) that actively use the communication interfaces between
> +       the untrusted host and the guest. This is not a new concept for t=
he
> +       Linux kernel, since it already has mechanisms to disable external
> +       interfaces such as attacker's access via USB/Thunderbolt subsyste=
m.
> +
> +       2. *Harden the exposed attack surface*. Any code that uses such
> +       interfaces must treat the input from the untrusted host as malici=
ous
> +       and do sanity checks before processing it. This can be ensured by
> +       performing a code audit of such device drivers as well as employi=
ng
> +       other standard techniques for testing the code robustness, such a=
s
> +       fuzzing. This is again a well-known concept for the Linux kernel
> +       since all its networking code has been previously analyzed under
> +       presumption of processing malformed input from a network attacker=
.
> +
> +   * - Malicious runtime input
> +     - A malicious host injects a specific input value via any
> +       communication interface used by the guest's kernel code. The
> +       difference with the previous attack vector (malformed runtime inp=
ut)
> +       is that this input is not malformed, but its value is crafted to
> +       impact the guest's kernel security. Examples of such inputs inclu=
de
> +       providing a malicious time to the guest or the entropy to the gue=
st
> +       random number generator. Additionally, the timing of such events =
can
> +       be an attack vector on its own, if it results in a particular gue=
st
> +       kernel action (i.e. processing of a host-injected interrupt).
> +     - Similarly, as with the previous attack vector, it is not possible=
 to
> +       use attestation mechanisms to address this threat. Instead, such
> +       attack vectors (i.e. interfaces) must be either disabled or made
> +       resistant to supplied host input.
> +
> +As can be seen from the above table, the potential mitigation
> +strategies to secure the CoCo Linux guest kernel vary, but can be
> +roughly split into mechanisms that either require or do not require
> +changes to the existing Linux kernel code. One main goal of the CoCo
> +security architecture is to limit the changes to the Linux kernel code
> +to minimum, but at the same time to provide usable and scalable means
> +to facilitate the security of a CoCo guest kernel for all the users of t=
he CoCo
> ecosystem.
> diff --git a/Documentation/security/index.rst
> b/Documentation/security/index.rst
> index 6ed8d2fa6f9e..5de51b130e6a 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -6,6 +6,7 @@ Security Documentation
>     :maxdepth: 1
>
>     credentials
> +   confidential-computing
>     IMA-templates
>     keys/index
>     lsm
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427..4a16727bf7f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5307,6 +5307,12 @@ S:     Orphan
>  W:   http://accessrunner.sourceforge.net/
>  F:   drivers/usb/atm/cxacru.c
>
> +CONFIDENTIAL COMPUTING THREAT MODEL
> +M:   Elena Reshetova <elena.reshetova@intel.com>
> +M:   Carlos Bilbao <carlos.bilbao@amd.com>
> +S:   Maintained
> +F:   Documentation/security/confidential-computing.rst
> +
>  CONFIGFS
>  M:   Joel Becker <jlbec@evilplan.org>
>  M:   Christoph Hellwig <hch@lst.de>
> --
> 2.34.1

Reviewed-by: David Kaplan <david.kaplan@amd.com>
