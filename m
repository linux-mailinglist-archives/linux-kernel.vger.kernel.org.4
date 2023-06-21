Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160DE738D81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFURpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFURph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:45:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34901BE6;
        Wed, 21 Jun 2023 10:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWe5Qq+30Ho9a58Uvp9yM0UkUDgpbDCnA/ZQOyo67JqiNhJaYCbnWdfiDdb2sU6NaJwEiuH6jykARqGDkPweV74fAEmrnGcqeW2BidknPyaz7BxfwRmbSvgfRKrlLp8wweEEbD1OU5Yty/iOwtHsS/Z3rC5mCvBXzXH8fxSOFH0rgiCe/2bLNMg0exY4qan6T6VeO5nDDfTafkuymfk9ZT28KTJg/B1qyHPynzfaTYsHg62mpoCGnUchAa6QTrEWwdNm9vFSiX0wjmCio0oO0Rdj5C0UQmwjCsNOTSRgonr9EnUPBmunAzzUC+bGvJVmPF85N7oozj8dP4E/TV671g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvrlpcHJfK09maf2mKKhAB9WgAB6t8awrdIylpdgNV4=;
 b=jm2Lng4165ZvjnyFToJgQmP3JtpiyfFrGEOxqiL92klSNnt2gd1wBNAlJhWwAWAHE/PF4eGFvlbWhob4pm80FPqiZcsHsKNqgc51u9PeARqeVORctZo4xasb5e436LdQvrqsHD6zmmLXo68SBTfSYdjZ6EbYGNQaPbGD9ph3GhUCSx2XQMPw6tZ2A7EOJiGgcmDQBqMzzMYmuPvHMQjGh/NYGi9SZHCpagJlaqq/vrlgzl8gSRDC5wdnm/PsB4rsS+VW25wiGcKSTHf4vmbinCZV+uRguUq6Xr9W+BjtMg8CXwFi1eTUDA8s8dX3x6QSgf8i5YQOsQcVD9gswdoM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB8117.prod.exchangelabs.com (2603:10b6:510:29b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 17:45:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:45:28 +0000
Message-ID: <d32dab41-6d98-a45c-0238-e17c5a0b4d11@talpey.com>
Date:   Wed, 21 Jun 2023 13:45:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 62/79] smb: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-61-jlayton@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230621144735.55953-61-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0326.eurprd05.prod.outlook.com
 (2603:10a6:20b:491::23) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cfa913-848c-4b50-cb87-08db727f4ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQP5dG41wiKH0aPH6ChxzayjwP/k+YFc8XvLGyJqOtdGeHjktj6NKpFn8iBGZOW0xW4CbionWybkrjoAMYJpe1/p0fJigXe5F/zZtmozygWNAIkQkjy7ETBjsWDveh5plTY85UVrERg2B2fdVRS9+tz2egnHxjSmJobSNgCVDovz6I7vKeG+9d5of9HlYnz0SzSpkcE/fadCVHvjMvhsSSFffSc/x7Jy1snSStZM6LVUVxadD8lLzdXQ1ruCvLPgQs3N6C/srJeMZzBKLPX8xrB/fOlFXBxWKgwH4J1ZwNgq7m7Z3SsSKtGKu7+p18iWMoj5VPfGc4Wr469MhMSoGh4sW1IoqxHEv3FCpMRBekOkKyyV+ZPTZ2dM6LTVKYZyiUe81sjZaIH4xItVkNU3/mzWjWn0QsoLKsnLvwzabZPe3W/uT9NRCbvFp0f5+dLOpBx+IlVUSMBNSg/zmuu86TB4LX2BGLC8rp2l2XXvZye7Uf7xPtguzrsFGeLbO4a6t0afkZ2lBh0P1ETIEdGX5fTBOcBkUMx0/dROlnlSHwoOpSAJD+l2Ytc+BU+YphM5BZA1XClqmi7gKQVEBL0gODm9LDkxD43HOUhBuYBqUwA6PN1eLOpOPA3s2Zu6f/tQ6Pm6K4XjgVGD6o/kqLxSoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39840400004)(396003)(451199021)(8676002)(66946007)(186003)(8936002)(4326008)(66556008)(66476007)(5660300002)(54906003)(110136005)(316002)(52116002)(6666004)(38350700002)(6486002)(36756003)(478600001)(41300700001)(38100700002)(26005)(6512007)(53546011)(6506007)(7416002)(31686004)(86362001)(31696002)(83380400001)(2616005)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJvMURleFlWVVgwUklVVUhUMXl6V3B0VXRLV0lHNERYeUJuVVJIaldBUXFX?=
 =?utf-8?B?ODhVeVc4OVNuNnM5bjN5ZENVdml0ZmZQYk4ydTNXVjBFZlRGWWtaNEMvVTVh?=
 =?utf-8?B?UXAzUkpCOGdCS3dMQU5xaVJFODVUbmRWQmk4dFQ3SXZob2dBUWw3WTMxaThp?=
 =?utf-8?B?UHBOUUcwWjZHZFNRc0tNSmxvdWZMeWU5QUVodzNjL0hvMnA2UW83czNFQlB4?=
 =?utf-8?B?bFZYd2tTQy9rakw0ZDB6NWxoTUdXc044NGNOUHpBbHJ0dW1mUGRIMDFVQ1ZU?=
 =?utf-8?B?RmpVSjVXS1RSYXRlZ1JwbFM2TFNGZDdtRHJWU1dlYngraDR1ME10RG5DN1dm?=
 =?utf-8?B?WmdiRnlBSSszT1R0aVA0QU1QKytHeC9nQnROcjdINVd1dTdTclo3VUpqK2gr?=
 =?utf-8?B?TWtpUksrUXVXSFA2QUUwcnluMWl3alZDUndxYnlKUEh5dGJ3MkU0eEtZR0hC?=
 =?utf-8?B?VmFLMXgrWEh4K0FzOWVVSW5FMWNmK3pYVms5WkpLS0k0S3IvU0JESzVDajN1?=
 =?utf-8?B?aTFyaGxIWnFVSUpuSEdjTVVrSjZuSXBOSWt0N2VHenpzKy9pa2dteGM4eTFn?=
 =?utf-8?B?K3JwU2xKRUNydmhtMlpqYnIvNWV3SkNkUDlEd2tMNVRDT1FzRDhrZCtFbXhz?=
 =?utf-8?B?cXQycW5EcGx2TWdDRzg5Rm0wT210SG5HenJ0STRrdFVmenNOd0FaYkEydmtt?=
 =?utf-8?B?SWk0czVQTjJNWUFOc094dklBZlhndmlzd0ptR2diNGdKRE5rOFZ5STlicncw?=
 =?utf-8?B?OXJIcE00STJ5VFpsV3kwNlJLeDZUZ2IxMk1TV2J5a0l3Nmw5eENlcXlRQlBT?=
 =?utf-8?B?T0hYVlJPaVBCMkZ2ZHViN2NWREk5UWZTY0QvNzRUdXBFY3JhcVc0S1VHOTEx?=
 =?utf-8?B?QUNZc2kyc2xTOWc2Y2dObHFSY0N1dW1tNFZLRDczMXhSM2l0RVZZYjJrTGdh?=
 =?utf-8?B?Y3RUZGdyN09CZzJqM2l5ZkZaVUxldFFPK2Znejk5YStwNU54RXZZekoycHh1?=
 =?utf-8?B?SVJmdDMxNzcrUG4vMDBCV3VoMmR6YU5RV1dUOXFLZ1dvdnA1alcrTGl6TWZz?=
 =?utf-8?B?UmViYU9zUXhESmYxZWNGL01DK29zY3JwaTBwN1dQQ1BqWHFYZmgzUFlhVjlj?=
 =?utf-8?B?bHFDVkxlTjJpd1RKUS9pWjZNWUJrajZlY0gxb0NON1VCbnNncmZjUk5sQXJy?=
 =?utf-8?B?aDRDM0MxRGp0OXlLWVpqQTZKek0wQlRzMXpqWXV0VFgzS1BDaTdaeWxxVE9k?=
 =?utf-8?B?azVrbUNxK25HdGZxRXFXQzhQWmxtZGo5Q2M1K0VMY3FKUjhlaFpzTEpNWmly?=
 =?utf-8?B?bzU1R3Vxb2RPYnA4bVZvZXhnSFJHWG5FWlFwNUJ1WlJSS1o1RGFoa2swNE1m?=
 =?utf-8?B?VWw5UDFaQ24vYUVmbHhsZEhCZ1hudGQxTUdiTHVrSkRiK1B0NlByWkNUU2NO?=
 =?utf-8?B?Sk1XVWd1aUovNVRFdDFsZHh2L3hZaXBTRnRtQjdyQzFRQnNmeU0vdDhyR1ZF?=
 =?utf-8?B?YzFqaCtNcmJId21URFBIYkF5eUpWM1pTNDZUNHZ5OSt6OHRZak9HSjA0SCtL?=
 =?utf-8?B?d3dlbEFMRThPT1lQeUNYOW01RGtDaWoxTmZ3MFhwOFpOWVZmbHJGL3IvaWZT?=
 =?utf-8?B?VmZTbnI0RGxMOW54UDN2OC9MVjczMXVYYWtkWVhITjJ3Q2JiaHJ6MCtLbVdt?=
 =?utf-8?B?TEtzQStVNzVHRjFDbmJlWDd0VjBZZTNzdDl0bDlyNERLaFBjN3dHZ2VNSy9W?=
 =?utf-8?B?QjY5dGNybFBhY2ZDd2k1alN6MTA0eWprdlZvZmVTeVBVUXY5NVVjd1JJTjZB?=
 =?utf-8?B?bmNYaThMRGZ1VWoyTVFIUi8yVjJSYzF1WDVkOUpYSjFKLzRpbzAvUHBHOWFK?=
 =?utf-8?B?VjQ4NTNnYi8yUFlwT2dub2doZUpJUVBhSE10WGZ2RlpTdGtwK0RZOUdKQnNV?=
 =?utf-8?B?WndyMnEzVHNsMkRNMXk3cFd2cHlyczNSWGZBSklLakxmWlh3ZUZzdXNEWXM1?=
 =?utf-8?B?SmtHMmoyYVNXK1RIamxONkdZMUxPR3doZEhCWFVSMzlOVzdUdlpRSFhydkpW?=
 =?utf-8?B?dlk5V0NESzIyanh6dkFQMGlVcnZnT2xsVEZ4djVJeVUrSGpTWlBFbmpySHJr?=
 =?utf-8?Q?eSbdH1gAFPluzqybHrN7RRp5Z?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cfa913-848c-4b50-cb87-08db727f4ce4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:45:28.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBOv/jSX8KZB/6XPKBL9AnGCyZWWZtRh7xWnvBqtfuM3saqvFL4FlCH7/ROo1zjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2023 10:46 AM, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Tom Talpey <tom@talpey.com>

> ---
>   fs/smb/client/file.c    |  4 ++--
>   fs/smb/client/fscache.h |  5 +++--
>   fs/smb/client/inode.c   | 15 +++++++--------
>   fs/smb/client/smb2ops.c |  2 +-
>   fs/smb/server/smb2pdu.c |  8 ++++----
>   5 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 0a5fe8d5314b..07fed94b7501 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *file)
>   		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
>   		    dclose) {
>   			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
> -				inode->i_ctime = inode->i_mtime = current_time(inode);
> +				inode->i_mtime = inode_ctime_set_current(inode);
>   			}
>   			spin_lock(&cinode->deferred_lock);
>   			cifs_add_deferred_close(cfile, dclose);
> @@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
>   					   write_data, to - from, &offset);
>   		cifsFileInfo_put(open_file);
>   		/* Does mm or vfs already set times? */
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>   		if ((bytes_written > 0) && (offset))
>   			rc = 0;
>   		else if (bytes_written < 0)
> diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
> index 173999610997..1c50d286c3a4 100644
> --- a/fs/smb/client/fscache.h
> +++ b/fs/smb/client/fscache.h
> @@ -50,12 +50,13 @@ void cifs_fscache_fill_coherency(struct inode *inode,
>   				 struct cifs_fscache_inode_coherency_data *cd)
>   {
>   	struct cifsInodeInfo *cifsi = CIFS_I(inode);
> +	struct timespec64 ctime = inode_ctime_peek(&cifsi->netfs.inode);
>   
>   	memset(cd, 0, sizeof(*cd));
>   	cd->last_write_time_sec   = cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_sec);
>   	cd->last_write_time_nsec  = cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_nsec);
> -	cd->last_change_time_sec  = cpu_to_le64(cifsi->netfs.inode.i_ctime.tv_sec);
> -	cd->last_change_time_nsec = cpu_to_le32(cifsi->netfs.inode.i_ctime.tv_nsec);
> +	cd->last_change_time_sec  = cpu_to_le64(ctime.tv_sec);
> +	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
>   }
>   
>   
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 1087ac6104a9..d986b280b6c3 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -172,7 +172,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
>   	else
>   		inode->i_atime = fattr->cf_atime;
>   	inode->i_mtime = fattr->cf_mtime;
> -	inode->i_ctime = fattr->cf_ctime;
> +	inode_ctime_set(inode, fattr->cf_ctime);
>   	inode->i_rdev = fattr->cf_rdev;
>   	cifs_nlink_fattr_to_inode(inode, fattr);
>   	inode->i_uid = fattr->cf_uid;
> @@ -1744,9 +1744,9 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
>   		cifs_inode = CIFS_I(inode);
>   		cifs_inode->time = 0;	/* will force revalidate to get info
>   					   when needed */
> -		inode->i_ctime = current_time(inode);
> +		inode_ctime_set_current(inode);
>   	}
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   	cifs_inode = CIFS_I(dir);
>   	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
>   unlink_out:
> @@ -2060,8 +2060,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
>   	 */
>   	cifsInode->time = 0;
>   
> -	d_inode(direntry)->i_ctime = inode->i_ctime = inode->i_mtime =
> -		current_time(inode);
> +	inode->i_mtime = inode_ctime_set_current(inode);
> +	inode_ctime_set(d_inode(direntry), inode->i_mtime);
>   
>   rmdir_exit:
>   	free_dentry_path(page);
> @@ -2267,9 +2267,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
>   	/* force revalidate to go get info when needed */
>   	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
>   
> -	source_dir->i_ctime = source_dir->i_mtime = target_dir->i_ctime =
> -		target_dir->i_mtime = current_time(source_dir);
> -
> +	source_dir->i_mtime = inode_ctime_set_current(source_dir);
> +	target_dir->i_mtime = inode_ctime_set_current(target_dir);
>   cifs_rename_exit:
>   	kfree(info_buf_source);
>   	free_dentry_path(page2);
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 5639d8c48570..52564a5dd2b1 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1391,7 +1391,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
>   	if (file_inf.LastWriteTime)
>   		inode->i_mtime = cifs_NTtimeToUnix(file_inf.LastWriteTime);
>   	if (file_inf.ChangeTime)
> -		inode->i_ctime = cifs_NTtimeToUnix(file_inf.ChangeTime);
> +		inode_ctime_set(inode, cifs_NTtimeToUnix(file_inf.ChangeTime));
>   	if (file_inf.LastAccessTime)
>   		inode->i_atime = cifs_NTtimeToUnix(file_inf.LastAccessTime);
>   
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index d31926194ebf..7a741ab6835c 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -4768,7 +4768,7 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
>   	file_info->LastAccessTime = cpu_to_le64(time);
>   	time = ksmbd_UnixTimeToNT(inode->i_mtime);
>   	file_info->LastWriteTime = cpu_to_le64(time);
> -	time = ksmbd_UnixTimeToNT(inode->i_ctime);
> +	time = ksmbd_UnixTimeToNT(inode_ctime_peek(inode));
>   	file_info->ChangeTime = cpu_to_le64(time);
>   	file_info->DosAttributes = fp->f_ci->m_fattr;
>   	file_info->Inode = cpu_to_le64(inode->i_ino);
> @@ -5409,7 +5409,7 @@ int smb2_close(struct ksmbd_work *work)
>   		rsp->LastAccessTime = cpu_to_le64(time);
>   		time = ksmbd_UnixTimeToNT(inode->i_mtime);
>   		rsp->LastWriteTime = cpu_to_le64(time);
> -		time = ksmbd_UnixTimeToNT(inode->i_ctime);
> +		time = ksmbd_UnixTimeToNT(inode_ctime_peek(inode));
>   		rsp->ChangeTime = cpu_to_le64(time);
>   		ksmbd_fd_put(work, fp);
>   	} else {
> @@ -5628,7 +5628,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
>   	if (file_info->ChangeTime)
>   		attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
>   	else
> -		attrs.ia_ctime = inode->i_ctime;
> +		attrs.ia_ctime = inode_ctime_peek(inode);
>   
>   	if (file_info->LastWriteTime) {
>   		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
> @@ -5673,7 +5673,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
>   			return -EACCES;
>   
>   		inode_lock(inode);
> -		inode->i_ctime = attrs.ia_ctime;
> +		inode_ctime_set(inode, attrs.ia_ctime);
>   		attrs.ia_valid &= ~ATTR_CTIME;
>   		rc = notify_change(idmap, dentry, &attrs, NULL);
>   		inode_unlock(inode);
