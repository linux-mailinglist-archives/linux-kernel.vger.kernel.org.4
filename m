Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A36CF19A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjC2SAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC2SAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:00:45 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011004.outbound.protection.outlook.com [52.101.47.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333C35A5;
        Wed, 29 Mar 2023 11:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyFG0pZL4EG8OhKtz/mn/0E0q6hpBxA9YepLcQ+jeKugfY7F6Ue0lUDXm1FN49V1r44Hk6WnyY1USVoh8F+jOavLQm0ETFHTYbCtprRM7sqKacAUlf81haEYmTp/el7zZ1B0Pk4eGRZqiFBq3oVXawK3K34ZigxXBXfxSQgg4Af50rnhcyROHm0r8cGUOnZVfeVaiKoqAyl+XWqeipY5Sczu6Yvu82YZlQF9Rh4FG4zEM0N8RwUH1GGCmnVRFhXCM6mxqw5b8uY2ejv9Jg8WPgPRgeEK0nFGi5JJgfOqwKGwPNES/MO5ZjUBkQwN6kjPNWdL0F2kTHy0vPu4/3nl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3PNEDIhd20iyy4QccALiqdW4RkoYttGKlmd8lrE338=;
 b=E+4eAlfBkq1R4zIev0UGUca0MsNnlq7C8on4xGYlBTJYNj3CkvutOGhSVzFvUl+uaG0WN9GqXNIzWM+NbDGNq4O6nJ3Bn+e29V2Kbp3qF9mpYYPRA6cvUdT4NHbTfVv/Ajvw4wh7lujejKJZG9E7XvaZM165FRdmPWWv7JFFexKgbC1MuZBiX3wQqCRsq5ABcLqloob+APnP+0xa0h51YajNmqkb+PEm17bRWnXW0yL0mm225bo08EiaRlxZghRXiIB9mVWw35y81h+cWuTywynh3JvED3rx3kjepPFZjwp6+SZN7lK4DllTUmFDI/Gijj3nMvuVhzbnTiyuwFqZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3PNEDIhd20iyy4QccALiqdW4RkoYttGKlmd8lrE338=;
 b=Gm3aTHdLlkTmVPkSpis+lZJ3GHrf2IqVhWgq3Bxun9K9hQlaxvnd0A0SITlE25kG9nMtI+1+9XSQTCm5PhZ0DegbX6Wf5BMHu8VPWC/gSjkduuldPe8sXSlNhnAROzrcnX4lUhnlp205BHgxOzERacIBFjiS8nf+nFE2aUZA/Mc=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BN8PR05MB6705.namprd05.prod.outlook.com (2603:10b6:408:58::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 18:00:23 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%4]) with mapi id 15.20.6222.029; Wed, 29 Mar 2023
 18:00:23 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH 0/8] tracing: introducing eventfs
Thread-Topic: [PATCH 0/8] tracing: introducing eventfs
Thread-Index: AQHZLoQH5dE+ZQnOVUm4TxmRzoe30q8RMZWAgAFCCQA=
Date:   Wed, 29 Mar 2023 18:00:22 +0000
Message-ID: <68D75872-2495-48E6-970F-6A414EEBE3BC@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
 <1674407228-49109-9-git-send-email-akaher@vmware.com>
 <20230328184743.7984463b@gandalf.local.home>
In-Reply-To: <20230328184743.7984463b@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.14)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BN8PR05MB6705:EE_
x-ms-office365-filtering-correlation-id: df1c08aa-6ae3-411e-430d-08db307f77ad
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zL5JBHEQdxbMn72nahCtjCYLgcNeXiHKZ6ddLqlbCCfMkLMkLnf2CpMSL+37R15F8a7yHCyzl3uKqydRPKEpBBWvI0oSpBlXBhdJQanm+1qEzz9Mt6nCVpxlwaMpWSNpSUZioq0G5pw9E14gItBx224LkXYRJhXknb9aF8l6oXL653SKQq2usnz8RD0T1xb57fY1jrNSLXmWbpc0W+DOplHu20A8g7WLBwW/n4t731hH6kAOiObk+ZwByYCe0+DxR3p96hG+8VbBKpVwNZsFitop2HGy8gcOwNaV2YZNTmHFvzjS+aWhHq8ARR9GBGVYtGxIa3ypTaFyTqXtulGSVOPmID7ElHSIjC+6EDEqCVx6JFq8HzqIFmQJgB00ykjcGggeBHQokFNKeOvg68VW9HkpnYm8WvYTS8n+H2x0jB/ZJLvkgO+qgLUAdoV/75cbo8ZVK9H5FaAdiEk8ixKJOU0k3QL/KRSkNqoThW+M5DHed/6tl/nIRLZRZQAeSV+Bj3oGMDHf/vyFcSgv6jqXHk2eGL9PiI/8ndP/YMkx4GnmBHAWeyUMb89NIETrGld/ESx4XVV2RN92IAqcFBf1XGbcVGVSALs+qOhxOKxsDb/DD6KXyJAuUwsPH3qW4i0YSSB5tDrl4ebteZUmsljg1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(83380400001)(2906002)(8936002)(5660300002)(38070700005)(122000001)(86362001)(33656002)(36756003)(38100700002)(53546011)(26005)(6512007)(4326008)(54906003)(6506007)(64756008)(66446008)(8676002)(6916009)(66946007)(66476007)(66556008)(76116006)(186003)(91956017)(6486002)(71200400001)(478600001)(316002)(2616005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DzVBR2/9Ue4v7X5+5/1wy5SVw9DgDs+iExJja7YCAHw8Feo5xvlePDidEG+j?=
 =?us-ascii?Q?eA2c8JlqXx9BT/j+GanETn53/JGgaLF5pbrOF2kAJ5h3SFqkzILDH6fOuMeT?=
 =?us-ascii?Q?Dd8Ob8QlMMKr3bdemfvp1857K40mS84G0l8qTStSATOXK6xjDdqosC/EtSX7?=
 =?us-ascii?Q?T3NTJygFQPqCbiDwiHimIFYZ9mdZfUyvZYBYu4H2tDiZU8tcqlJz/AWRKlUs?=
 =?us-ascii?Q?FIbzZyUpgIRH8K5ZtnduCX5JRoHYpv4FjaSwxI50Ywlxy8cQczWFT1I7MVo0?=
 =?us-ascii?Q?uCuO5LoPP5cUcyYmmKVxL6apswuNo0UJ5vErqkrRhHCyP0TByhEHufA+zkcy?=
 =?us-ascii?Q?S9oy+Ioibusq/SZ8djj901VcAZBc4H8RdcU9sQ74la91XfVGY9aH36uHGm+S?=
 =?us-ascii?Q?tJOMcfG7tTgGf2eLMDQq1miv9rq/PkPIrpzMyT0waqfOclE0q4lGOl4f5H2u?=
 =?us-ascii?Q?F94erfweZ5OUGyMn1hFHWiBU614eopGeBWPfQfdSrejjiW28xeKk7b9ChvbA?=
 =?us-ascii?Q?XWctYhUvShFkAWdo2rpLfpIgSBp1LawcA4uc7bgg0188/8T9rjdFIXKiYKHG?=
 =?us-ascii?Q?dUZLII6mkNAmznxuvOmXSMIbzYVpn16bZhJZFpy7nu3W/u69+6t8hds/RTFS?=
 =?us-ascii?Q?VX7EowzHAoCLDvKfs8fFiJ8elxwNoB7uvF8XgF4B58eJPCCIgaLm8JvdKl9r?=
 =?us-ascii?Q?9ZxVM9iiTsSNwZl1+mWkoUwKBrW2HukBUWwnvB6uX5hY0s3qboveSuMnM9aJ?=
 =?us-ascii?Q?ZcuUjWMD4c1nwIM3//HDjcnEuNLBd3DUqs3+7ZLeJyIL8dMWKEvbhWcUZEj/?=
 =?us-ascii?Q?0FXHijtZsLS3VVsAZfAbbsXEqKVnjYfrv2kTXyY2FKbWcW64KAJb59jbTxmd?=
 =?us-ascii?Q?utBhq5X7kMO8rQkOUklCKKeA/9gIW6Z/jkrFJx74rLq9Vg+hgr2xSKzqbeA7?=
 =?us-ascii?Q?pVr0UaHqvSgGD3+fCysGlNK7fyFPi5UjueM3VQ3SrJfC9byjyZY4+54T9rVQ?=
 =?us-ascii?Q?2j0hs6BcWxFXKZvrdmZln8wPvLXPE9ID/RfYVslSg8CVG2vNpiqmPrAWbJug?=
 =?us-ascii?Q?W7zZgYXjS+sU/0mHa3BiRnxeGlsrb6iEYTMWR2CoQ9KIoPDFEaILjBZOdwde?=
 =?us-ascii?Q?uWffc8DSDpPgIMFiWfVQwVBDcc6PEmRNd/oHT81NczPdBpDv/h7U7VPJ2RtX?=
 =?us-ascii?Q?/s5XG+bP/lFCw9MJAuPe9G6NM2/ML2BC9sf7uyHGtnNAWzv0oaBsBXPYWiTQ?=
 =?us-ascii?Q?ZJHGSyqIIpSFYEwcnqitJKZmjDZIKUaO29rePeNNum9aoPUcakOdNJgKgjqY?=
 =?us-ascii?Q?lj/PVN8BMxn1mG7Q9FQDkwot3bvtBeYNxr9Vpf2MntI/DRAC2+yaCfJDYdIo?=
 =?us-ascii?Q?vs1BSXHviQd2uqoGFmCKQaa8GUXmrXD1Lnsl+htsiKWITL7xKLX0vFJtEja2?=
 =?us-ascii?Q?05KZYp7GaAlgJmKr+vTHRZetkHAhffN1L6BRwafSfrOup5WTiY35mRceJHP7?=
 =?us-ascii?Q?bqQS+Ve5+5H01cz22MiMwKsj61MEE9KE7FHlIOvYdQi3/Dg7YeO8SeplBZa9?=
 =?us-ascii?Q?BJC8th/0wUYX0dLhs41ePHk+YmjPzElSh1W/X1La?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B141CB4B0B7D4429494213E1B59C60C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1c08aa-6ae3-411e-430d-08db307f77ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 18:00:22.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+qVKxhvrStJOJxm+ny5kWe7kty/L5dk9ZpT7GSTHuiOwnYEHsAliYqrvyJ5ikKV53d2MS6ldEfgcl7R3tjuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6705
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29-Mar-2023, at 4:17 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Sun, 22 Jan 2023 22:37:08 +0530
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> Events Tracing infrastructure contains lot of files, directories
>> (internally in terms of inodes, dentries). And ends up by consuming
>> memory in MBs. We can have multiple events of Events Tracing, which
>> further requires more memory.
>>=20
>> Instead of creating inodes/dentries, eventfs could keep meta-data and
>> skip the creation of inodes/dentries. As and when require, eventfs will
>> create the inodes/dentries only for required files/directories.
>> Also eventfs would delete the inodes/dentries once no more requires
>> but preserve the meta data.
>>=20
>=20
> Hi Ajay,
>=20
> Is there going to be any more work on this?
>=20
> -- Steve

Yes, Steve.

While running tools/testing/selftests/ftrace/ftracetests got crashes, as yo=
u also mentioned.
These crashes are because of lack of synchronisation and bugs in eventfs cl=
ean up path.

Locally I have fixed all these crashes with the help of Alexey.
I need one internal review round, once done I will post v2.

-Ajay


>=20
>> Tracing events took ~9MB, with this approach it took ~4.5MB
>> for ~10K files/dir.
>>=20
>> [PATCH 1/8]: Introducing struct tracefs_inode
>> [PATCH 2/8]: Adding eventfs-dir-add functions
>> [PATCH 3/8]: Adding eventfs-file-add function
>> [PATCH 4/8]: Adding eventfs-file-directory-remove function
>> [PATCH 5/8]: Adding functions to create-eventfs-files
>> [PATCH 6/8]: Adding eventfs lookup, read, open functions
>> [PATCH 7/8]: Creating tracefs_inode_cache
>> [PATCH 8/8]: Moving tracing events to eventfs
>=20
>=20
> !! External Email: This email originated from outside of the organization=
. Do not click links or open attachments unless you recognize the sender.

