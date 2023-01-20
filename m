Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71311675DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjATTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjATTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:18:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288961167F;
        Fri, 20 Jan 2023 11:18:40 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGD8TA019608;
        Fri, 20 Jan 2023 11:18:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=jI0rZ4SaZrkohoDBDgp8Qcdn7uEMCGxO33V6e4CawN4=;
 b=PYbU/iULI/h38bAWhU+8QMklEyQZKJYwnCPl+yT01uEzM17tBlooiwh9k6AvSkGg0M8R
 quSlnBsp666kqIzsF1qS0OOTVO67lPmcwB3WD6vdIKF9sutyfC2KBT+5HC1/PXY+kXo6
 rK17AvCa/KUt65/Ln7GScV7c4KLSBiBGsw22pAxJ9rhM40GRj+uQxuWXX6w/uMAfpptX
 x5SmRU9d/kojuENKdgE9ue4mKS8niMPBldLX+ARVeduyQjPXbmJXtc5m4Nq80JaKB9FZ
 COXeL1pc0ZBJnSW2FwZ89wefrZKKmV4evRkVAamycTmBIBQsHQeMf3gV8pe9CzfwQT2R vQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n702vjra3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:18:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7kZmDFoXA1GPpbQoDLBSeCgUd4faW/Xy4S1NWKig49LkKss2Usv6hrR3L9CbFPzIWvx38bYOzWAHNS4lRwECj4sg+vpJLPGVNkz9W++5o/QPJGgEwGVtBv1X4mNEOqtVvI6uGA2D8Z1j6AaiMJi/lqNX7mLDYoL/12pEAq1yR/u+hh+d4HNAIbuNw4iKArwNkNr+o0lmo3Udj0Gq89Svm1hDVt+pvrnbZa+8Fwd/i6oZWXMT79qK6/+Z0UiS/hw089k4QmoT+6ecTWVYIxd+fWPxFoQCuCBrmfXiVkUuTrqRp5b3Rabp8ZZ1/AeiFRfuy12rAnRWcXvc3bJhQ0mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI0rZ4SaZrkohoDBDgp8Qcdn7uEMCGxO33V6e4CawN4=;
 b=NwLQU1OlASwCGP1bOY0lpiKVqtUclQR7cKcgJ5df+YQM3Ye7FJq+KKtxF9bYRVCPkdAHu/iNAel7pIwAaUsCRVHSHIVP+zJaRIOr8jycyVoR28u+CO7Tdv0dqjcW4IfklSK2rFCscnb/UXklBR35GNP3bcF2echDgrb2uQKQXy4i2ViFW50xd135csbBmm4j0r74pUWs9Y4GZNjak1cwEx0bqQZMK+mndoOhYoZzk+DTH7AOPe8M0z2YroaGnjj5DrGNJ4c28anOhv5a5GKDBsnajUxwEItIL9TQzmVV5ECEhRLt19eY6zB3ob61IVI+xKY6H10C3goA7ZYaSqZN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BLAPR15MB3969.namprd15.prod.outlook.com (2603:10b6:208:27f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 19:18:35 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96%7]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 19:18:35 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the zstd-fixes
 tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the zstd-fixes
 tree
Thread-Index: AQHZKSUW+5N1z1l0x0WPVd3IbvGb566ntaQA
Date:   Fri, 20 Jan 2023 19:18:35 +0000
Message-ID: <D1A16450-8FEE-4601-AF3F-45066B6B7A92@fb.com>
References: <20230116080514.34ee3baf@canb.auug.org.au>
In-Reply-To: <20230116080514.34ee3baf@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|BLAPR15MB3969:EE_
x-ms-office365-filtering-correlation-id: fe06c3bc-9842-4c0e-598b-08dafb1b2062
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5qmYfm92UCWTQxVHUsiLB5dRAeD8jO7RMHAdu9xyFQpWsAMhqPU1JrTQQ43EDzi7lymYO+sM6IqOJ/wTEBpR65Nt9d+66sDnHOkSy0Pfe56R8hB6eqL0G9EwNyNTdKtAZQ9Qtw9eDGdBAfoOtiatCzJM2qOrhhH5ZOvye0vC2tNhW0dthVUdxE5Xo0fmTBHMU9caV3g5meG4dLEGtOb6PT8neVzULoPTgVp5BP5OQAwgwSZ0Uh1G+cd5E3h4Ls3QuDh0ItrxMtOrNGKs1+glEe5AFK55IZFiFZFd8HaE/JyMnHGwWYp0QfbTR4ecGzgn7jNCuY1MPzj0JD6/Xb9rw4UMzEAsksaKRPoi95Vq22Z7DgctsDOSc8vF/2kz1/T0jiZSqSjvRvArV/9NMxaC82HR206aAVm2l1iC1dMg7G2EAXpUZNo+j/KnKVoGLstST4rrWlgtYnvozVQSVug0RCBF0oSJHx7YuZOyJN9Iw8agsF0F8Iww9AAOmJ5hnFTQG0q53r1eLYAPpKu/UVuNz3JDI695hNnKqmzpI5bzblQEG/DPVwHCTHm077TxbVZpTcjP2kkHoCmbFFtuo7HxU7I5w1BxnFj2UQD8Wp3YiAssOWbHo5KgvDsAGkfQw/udkpxoCxvJDivD1N3yZJ8Jm6d7DF9hK7ZWX7mO6mAVR5ytINOtidOfKW1NX8otw51WYBU3V/jNzSeZNfiyf+1mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(186003)(2906002)(6512007)(26005)(54906003)(9686003)(6506007)(53546011)(6486002)(122000001)(36756003)(316002)(478600001)(71200400001)(38100700002)(38070700005)(86362001)(33656002)(558084003)(83380400001)(41300700001)(4326008)(8936002)(5660300002)(91956017)(76116006)(66556008)(66946007)(66476007)(66446008)(6916009)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmP8tYs3obkcztElbyU0sCwuuOMrxokvNK1ddJFmJcI1QfNlItCYEky6kJqG?=
 =?us-ascii?Q?pEJ/GnVoNfSayfdouSPHy/tfv9/iJriJ8IxqAxRKIi0k3xyYjShyQr7GoAbb?=
 =?us-ascii?Q?gGSnyFwBVvALsWXdRfQHAlvMx22IMXlvuyK66cvDrPiCG9lLIrmqMVztqXdR?=
 =?us-ascii?Q?FH3pvc+904N4IfyrcwUBBTi+Zsmq+AaTkr/GXkr2xJyAzH7yemogpTe9ZCAK?=
 =?us-ascii?Q?LMxsdM0ZkdUCL7qEMLZnh151jU5Hpe3tJbAZNZGjvjHy2Xnh1qPjsCnidWeJ?=
 =?us-ascii?Q?f4S1g23ShezsAUD1XyV2EMh4KrJrBOAAMv6y4rw/D8xRkL0uFo24E9gt77Ab?=
 =?us-ascii?Q?ZPtSMhdsxE10mKI50TQnUNlZ7sLujvoHD/5e9eDWPWChpnbJ3cCRzWA+YNQz?=
 =?us-ascii?Q?UPv18j0NO0atZEyIYlp4W6Yw98JMWdadX9JVJPYkqBTIodE6MsIC46H8VqZP?=
 =?us-ascii?Q?XV2jksEvgOsd1kOc/8pyi7Kc+Wew2zMmAhEp/g7BXomy1y/TNlzo3w3t9KdK?=
 =?us-ascii?Q?/a+W6rv/z1/pAKMeXcHRSeaO7CLtXpbB0hx/S+MnfXBQue6KxhPRpDElfK/S?=
 =?us-ascii?Q?XfNtJGMggNCgNVXUPX761DD2M3ubUyf/IyNubCAqIrAjy62097z+mvFJOCn2?=
 =?us-ascii?Q?JmtOmR6OyyaaaRTgHtfXMmapk1D86zivdbjx3NaxhDIgHq5mBmU/sd+Sem9G?=
 =?us-ascii?Q?Vk18Z/1Z+ru+c2nDZDypgJt0aCMjn5NdlH5ywUWIzfYLkjJo32PqZesZEkrM?=
 =?us-ascii?Q?kiGZvE7UyyWzmHgBt4gXwjYEIuryNUcBASoGy987+4U9JE8vDzwDuYkn33u9?=
 =?us-ascii?Q?hWJn2Zff7feOIqxD2rqd7rydrbYc+wthiBXf6mv3uJqMJ84NIx0SI2QaNGOZ?=
 =?us-ascii?Q?n1Yycpcl5SZF00bbuLqj49T7wmHsEGWdQgOcp9DPincwp9WU3RBVd9PSwjYe?=
 =?us-ascii?Q?O7Vj7ByFkaEB3GTrRcCz0TbKNDAI3hgyMnIN8e7ZO9R03j6HYFPjw1F0eodo?=
 =?us-ascii?Q?LDrplbpUbEjw9irg/pO67jSJL3S1mRPpSdtijmF6fLHEyImOchjVhKXks3D4?=
 =?us-ascii?Q?yjdE4ysIiVKzf/bDgRXvpqgkK9WQyN79VPCS63L+9WajC0hFML5zpSS9BjLL?=
 =?us-ascii?Q?4hllyM5A1RgoS+TpwsSTNLrnZDsDmpnzvKJp8ddziuHVbS/HXWcGRXYDLwZC?=
 =?us-ascii?Q?xVriCKqaVnyMa+BmGg2qzidEhpR5yWIwnWuMcJFvPlWq22rOUo4EAU8Pju0F?=
 =?us-ascii?Q?tfBCQgH6Qdo/yYGPgqE7YO/Irv1AhPbCTTsiX2dv6fv68I5Lk3QDgRJefUn8?=
 =?us-ascii?Q?/pjvz6t4NKKTuNmBy9opp8cGXZ6p71xIyu3SmzHiAIkzNl1loWC1gyY10EMt?=
 =?us-ascii?Q?y4jOB2OVtQjnu1ZvuX0WfYxZRuisROKHlvAaO66ysgOvix982ZDMvhkIh/OX?=
 =?us-ascii?Q?YvwwhtoxXgvzRzWraFYfiu0b/Mb0VZQpNVQuvnNo44CO+z3i/kDJJoXDAMI6?=
 =?us-ascii?Q?ZjjHeX0yUjggJJ/aXfBZQCCFHBtqIDiwt8wxGUHzFC5LdVq2eYb27juIX/ex?=
 =?us-ascii?Q?XURx8wLun0PWkjZZtGh+hB/hcXyO6CBoetPdQ3dR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A40666124961FF47AC86EAE57978F926@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe06c3bc-9842-4c0e-598b-08dafb1b2062
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 19:18:35.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v76Btj3dB9JfIX0AlMU4GrO9vfMh1+T1KLLhy3W/4nKQ6etH8Rc5xjYxlNI5Tri+NqUnpK4BY34sYafVdd9q5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3969
X-Proofpoint-GUID: mZO8VraNdQJha3MVyRPrsecFBznbP92P
X-Proofpoint-ORIG-GUID: mZO8VraNdQJha3MVyRPrsecFBznbP92P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2023, at 1:05 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> Commit
> 
>  8cbf4bb547b7 ("lib: zstd: Fix -Wstringop-overflow warning")
> 
> is missing a Signed-off-by from its committer.

Thanks, fixed!

> -- 
> Cheers,
> Stephen Rothwell

