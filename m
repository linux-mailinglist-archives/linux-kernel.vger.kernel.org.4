Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD926770EA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjAVRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAVRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:08:07 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46F1B55B;
        Sun, 22 Jan 2023 09:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvjjuEhikORm+ebne1JxdanJ7DbrPni/Dv3I8/S1k95P5V2dNs6FhYJbXFFwPy5kgtoUzlGTuuOUC0ETvlQPP/sgcHbJrYGeXX0kScuoMOvftkgddbQSDpUz09B13v+24kEboqeazQ9zFVS/6lOy9Oni9vWvZmERMXyIzwPPy0HG/qr2C54l0jBgRB81KrO8hNtNT6s9DGu2NDonPKjUsfmfyhYDN0lntXdy5skLPUHqUSfxgrlVlskTZrEJdCHyE9FkDzxr8zu+54NLCQYMorGyqbkcygAlYRgzZY7yduBrKEh3xhI5CQAqm28IFroiHHB372Vth1LndwESfcQDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bJZBhDGoVQYhe4Qb7KJMhyc6DKqVDiQnXQ1+l6dVs=;
 b=eh5OxC3SQnrYQRyI4dn/LPLU9MqC76wTddpvQayMU+BpsgpotI1UTaIaRbrugZk14hg9rPlMQJUQpkppOxnOusFAUsEQK1jpx+cOp//8l4UGRA5ebg4r6hgUiPaNb4WDzjIox9gWNvEe0/Hw8cHBRKQVlf9vnZiWrmw9rG/Si60/yLGHuwizZfvafRj1AS2agS8nNPFYZTD8SvTfwzqlRUkRy806HTyXKMtzW9kH5U1ChcugKghwnn6Gv4pefvRR7XOXdoulpOgBhKqGm2WjXnaEUI4dUxFyemrkyW6bbn9n4Ki3jrB5+0pu+1ypsOCD/Ykb+vIDtqdbrzRyfI+V3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9bJZBhDGoVQYhe4Qb7KJMhyc6DKqVDiQnXQ1+l6dVs=;
 b=nRgEJu4ckOm1afrdl0mT1X/7nI/nXVoWq/LxdXxbl9M7lLjIoz50yUnnt3rtteMLz/asvB0cy8cWtodAFjced90ia1YTzuj5V3KMm8O0fp05AyA2BsoHMXVZp3wvPkBEEFDj84N9tmTjfRVcjmxPR3ZOSgQoPihinDUfVRFo/Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:38 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:38 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 0/8] tracing: introducing eventfs
Date:   Sun, 22 Jan 2023 22:37:08 +0530
Message-Id: <1674407228-49109-9-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674407228-49109-1-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbf9280-4028-4ec6-ff3a-08dafc9b29fc
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfZnylaZqGyjw1W6AJ9kYQkA5VdpTbgCEUtMnT4R+bNAZXW6q346T88m/HShYEmj/VjGFEigWBk1wyVQhK2912dkk9g04Hjjq2A8ETWtAx/H9M8CoUQcH+4ohJM8XtjPpetrAycx6UggFQt2fuZ18p0d+GodnopwM1IozUO2pRWw/66+Z71MGpQLWdq7T2V2OSbQ9p4NgN7ehQmF2ugGf0XPpAjtUEpRvQ31pyP3vhagJktpEVI0GcIF8Umk2Pd17LHvQCyVEhG63yWz5uB5TYBXIIPDRQ89CU3HZhESaMan5E2cenEn0XYiCMqpV4nbmV5eXpUAMl00FQ0+jOG/5H3DtmRARBCUQ8J+Q4HEfq1XfqUUqwwH5qyWdlT8Z+pggM+zsvpWThLufsDuwQzVA1lDaHCko9wm2jKTPzau3YpQKYAa8623JFLLBVm9+o4gU/rOxZOmgc4vRubChXkC2LfzXfo7kVacJQMt/eVsH/YSQYRlBzX07Ys6AvpY8mEwLguEPEXpSyCnQcntyQ+TjTd9R8Co0QX4gc1oNeooGvl8W4Xs6IKvJB0SxRhJ5dPpmifu+PFmTUu5AoTIenoKjlwTci/QVtTq7n3/Uo0fqQ0lOXnEDRnvrzkFfyi57uKxdNGNAAbFCj3TOVGs8cJSuXRgV9M7K5P6Rf/NLCLbJb2F8+R+3a385xR40VJT+8232Nh5QtPd7cvNUmVkPVvgqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPSZWXta1m4xBz3pM21XqxM0nGIIrBUqJd3TSFt0G9PcW70CoNV4ogBOcyTx?=
 =?us-ascii?Q?UhYfttg1wSlCyPzL/EJFWV5hcpOmH+5dTFGX5B8fWuA8qydohL7GjIEw8AML?=
 =?us-ascii?Q?FBCaon7UIdsrg78F+WzHOAqbO0iQGLsgc8OfO8eSyoL11bdlPdUKJ74frYcz?=
 =?us-ascii?Q?3/Um+sleWudcGPBU0vDpgnDBjtsfat6hfogDxGTgGEVoX92J4D7iF+GNw+2r?=
 =?us-ascii?Q?Rl4Tl/Ify9TalgRaWSiM/70jb8QqYPbBi/6X2O1cIJugeM/tuWYIFJvKJs8j?=
 =?us-ascii?Q?jqGYsgfdF+Lwbm/zwkc/l/3l9z+L9FnMsd+PyjB/tn9/DcJwlXm+GKR035bi?=
 =?us-ascii?Q?YVfob5ceSIIja48/SzLXrbdqD/88oBeDONDcXKozuIUIroRiTZ82Vk4H0uIp?=
 =?us-ascii?Q?wu+DO1F1EZl25wI6BOmmdGHJp+RT9lviyIXUdnoFBkv5pfnQjHuttaCdQgLT?=
 =?us-ascii?Q?mgg0CRiMvsjcPLnZ2OLsYgruPVUy9R/PtEbksslAV8AbRwxBn1lj1HWs58Uj?=
 =?us-ascii?Q?4UD8pnCFL7v/xZpzZbKmjk9zNPZjmhBmr+Bzjnf54Yxis5CWR7uD8I7R+jdZ?=
 =?us-ascii?Q?dC1bVts4847IR1AnKLKKjNTXMRzcIFSAkdC+2CDbhae9dnxI8UsZxkDon1MK?=
 =?us-ascii?Q?G2QGuxIF5F+52DfnzSkJtvIh6oh+ZxVXcA4oFdexswO2ofOBthThJMczyvi1?=
 =?us-ascii?Q?xx0IZx7A+VbyJtEuTIjzo9ssIV8xa2WEq8p8gKNdVQoLCB5WnuD1fb6CKBXU?=
 =?us-ascii?Q?XpR5/dHVNmYJLGeQwdtAxvETwRi1DLHHmDIsbkg0vlZrZ0N6rV1fEh+vYU4A?=
 =?us-ascii?Q?ssXiHVC/XZ56ov2XrvGhjAeLAGfd0BozWvqsNtQpRh0SzioPvC1V1VBK4NVL?=
 =?us-ascii?Q?K989dugp01iVd4W35YJpUfo2RF0WBpPi5PxuDYM5ubOxOuZvM96AG3KvIUG1?=
 =?us-ascii?Q?ik6yU40J54mFKAE3waBnpDr7pB7rh5xabkyrXw623cs1Cc8fX6CMf1rc+OGc?=
 =?us-ascii?Q?QWqnUJZwjzGnHjhj6CqecTOXq82dPpmpKhepJwI+RHXL4srmgWBAPkBOyybm?=
 =?us-ascii?Q?4HscEv/lHS30g+hI5OcG0iJBtplLcSO64NKfNDd+WL3IMLAuh3MxrHNQRUDc?=
 =?us-ascii?Q?YJtXuw0D+vm9ajBvj8jJfUsaR5OxKx56di2JAsIfe9hWCcbrtou6L9X+x1jk?=
 =?us-ascii?Q?EekrlgMQFGYpRZl3AkcUBIqQunoGbLu/RyCzNxuimdisEpKL6lBNFryOOgHp?=
 =?us-ascii?Q?afGmQtOPkLYsGj/DFkCD7Hv1+4kK2hOTBNU3s/mY455hqqTH/yf90WySmil1?=
 =?us-ascii?Q?TAKR9lVC7sfKyhEPPDVaDgYKKS6ap2CVjJtqzhc6cy0LInAiUo6ZjJmI0I55?=
 =?us-ascii?Q?7kKoq9s4ZOdgN4G6crUr8OUgE3M3qO6fOwcpWqJ4F812bfaKVL+TDPP7MF4w?=
 =?us-ascii?Q?ezh/HYscMrG2TsdbkO6sGZvWAw629cAH8j/Eq2d3CbKjkcAAV/2Iy+Wn8eOf?=
 =?us-ascii?Q?PUzHXm/RY/eQWZZZsUYAaDuvSNx5lcamKD3JOVTBYfNeVpUZR8a3DaWXD+rx?=
 =?us-ascii?Q?8DkU8l1035yS+ZV4yLFh+uS6MrJR+C3ayyqpBq6Y?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbf9280-4028-4ec6-ff3a-08dafc9b29fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:38.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpHmqAKaVt6/bS9A/pSXHYfEnddHhLqKIaOH5Vhwm/1LNmy20zNx2bpkj0GbUS9TfyPqoxyMhfKf4+PO1/OorQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB9322
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events Tracing infrastructure contains lot of files, directories
(internally in terms of inodes, dentries). And ends up by consuming
memory in MBs. We can have multiple events of Events Tracing, which
further requires more memory.

Instead of creating inodes/dentries, eventfs could keep meta-data and
skip the creation of inodes/dentries. As and when require, eventfs will
create the inodes/dentries only for required files/directories.
Also eventfs would delete the inodes/dentries once no more requires
but preserve the meta data.

Tracing events took ~9MB, with this approach it took ~4.5MB
for ~10K files/dir.

[PATCH 1/8]: Introducing struct tracefs_inode
[PATCH 2/8]: Adding eventfs-dir-add functions
[PATCH 3/8]: Adding eventfs-file-add function
[PATCH 4/8]: Adding eventfs-file-directory-remove function
[PATCH 5/8]: Adding functions to create-eventfs-files
[PATCH 6/8]: Adding eventfs lookup, read, open functions
[PATCH 7/8]: Creating tracefs_inode_cache
[PATCH 8/8]: Moving tracing events to eventfs

