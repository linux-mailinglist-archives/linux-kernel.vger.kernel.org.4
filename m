Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD8697280
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjBOAJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjBOAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:09:50 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB4928D07
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:09:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s20so11454396pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0sihCLzH1qcCbYBUaUFA0Nuhq6iz4Sj6JaL71mdHTA=;
        b=LTg0ADzZVyv7chBkJFhU58Igqer4EeBfFh2yBUTCvnlw1Fy3I9/r5D1xylcnlFC0Fm
         Gc9rM5gnMAhv40nXJl7Jta459FnJhE481JHVRM89lkVJW/I2PQq+9asHd8BryXUjO0u6
         jc8rvJUgYpphbuOVxc2SoTS39eS/RQjYf2IRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0sihCLzH1qcCbYBUaUFA0Nuhq6iz4Sj6JaL71mdHTA=;
        b=pNN6rcUsRmR0XoTA1PBh54HqFi6y/zsZZsQ6K1up453w6+4JwLW0fyZh/ebcVZ7lIz
         z8JsjNIblpWoRLYZhzxFfrt1AIqKyx2ZmQhNHp96F1eyHMmGvJAviifidK24LEXWQCBP
         pQOpNlORiLwrZ286936qJ73Z2JEkxTAM4Y9AxuE10jvfXAZnMnbk0n8hYh29U+2dfcFf
         hx4ew3z2EHV5fT5rcrKYZP4dk2b6t251QprAF4VyKsRUcstvEs1M6jYIOEfxkp4GStAE
         WlbhsRHutupmtvFFfX0FVN3i8JY6UVmjpUlHcnmYLtIm/wi4o1jCOagUkbWpRA7Qw9Pq
         y8JQ==
X-Gm-Message-State: AO0yUKUBcs/KkPD/nV8wo7Tw47mH+6yRqubDKGCfnFIKTlyetMKkt1ec
        VBbJLaY/5kc7xZ80SlFTgwnrzw==
X-Google-Smtp-Source: AK7set8JFVc/t2gYkliyFF2kB0LSycva7FewzfRcbr6vBfusZs0m3BdLHgWx+S16mtxYAsg6W6Nhdg==
X-Received: by 2002:aa7:9acc:0:b0:5a8:aa9c:8524 with SMTP id x12-20020aa79acc000000b005a8aa9c8524mr43165pfp.10.1676419787573;
        Tue, 14 Feb 2023 16:09:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b17-20020aa78711000000b005a8c60ce93bsm3673633pfo.149.2023.02.14.16.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:09:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <sfrench@samba.org>
Cc:     Kees Cook <keescook@chromium.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] cifs: Replace remaining 1-element arrays
Date:   Tue, 14 Feb 2023 16:09:45 -0800
Message-Id: <20230215000945.never.734-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17718; h=from:subject:message-id; bh=KAVymXQ6G1H7HAKYADVeBusBoWGpd7dkrSHQQQT0cAk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj7CLJG2/QzaJL4nY4I8PC8KGsBkxlkhpd4xD9ydhY 8r1oS9iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY+wiyQAKCRCJcvTf3G3AJtD3D/ 4tMy+zF+cPe8CDZDWE+CaXQ2xk8EIEn/VFBUGrNN9l34z0MTSxUfHwJwJeBtiFhqNFx78QeCVs3Epp 49+fMNcX2k6RfQCyOo0jgYn2/B4lASG7RXj4EkFA47CjWsX+cSM/qef7OkwdFDCcqcGHQL8qvKTH/n oetLyJrC3u0wcFAwinZDNYCNS5B2GbBDuvexoVe0+yqzDy/vWwPXmcnSssWMoqjWXwvuWBFQmoMO6w biqbNmTTxqJNOvHr4xa0agIor3gjGIXD5xEB5ovHSyahx8LNeXIkAOi6Z3Iu8hsODgQGKFu1SY/Jh8 5xsoplvY8B4RfasmJ2aHMRSmYG0tOIV7y/xLdZUUI3VbxO77w4xu/Ca/knbSR7Oe5gUbr0IuXxhnrL x6P5i+eJgsNlyJY5zWdHFSpB7u74wyU0G1VTkwVnEWjssAyArimSzjeL4+JUjV6OxEasZ9OCSamZ82 UFdLvqN/ZNSShPm/d+QdXz3r2AypzvIRT5raJWnnoBLyoCuLm8FWzERqlggp72o73RhN7Kafz3Ta4w kQOdLxXKGJLLynOqNze2Dpy91A4LfDEDiMsTintomaCFcmNpvyEBrSpekDdQKD1WRFfyUFSLsnUR2L 7tbStnFaisXureoX+DwOrN/jRa0hWEeZkVUHEHzAhMLrjFX4SyXfbbjrXhEg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

Replace the trailing 1-element array with a flexible array in the
following structures:

	struct cifs_spnego_msg
	struct cifs_quota_data
	struct get_dfs_referral_rsp
	struct file_alt_name_info
	NEGOTIATE_RSP
	SESSION_SETUP_ANDX
	TCONX_REQ
	TCONX_RSP
	TCONX_RSP_EXT
	ECHO_REQ
	ECHO_RSP
	OPEN_REQ
	OPENX_REQ
	LOCK_REQ
	RENAME_REQ
	COPY_REQ
	COPY_RSP
	NT_RENAME_REQ
	DELETE_FILE_REQ
	DELETE_DIRECTORY_REQ
	CREATE_DIRECTORY_REQ
	QUERY_INFORMATION_REQ
	SETATTR_REQ
	TRANSACT_IOCTL_REQ
	TRANSACT_CHANGE_NOTIFY_REQ
	TRANSACTION2_QPI_REQ
	TRANSACTION2_SPI_REQ
	TRANSACTION2_FFIRST_REQ
	TRANSACTION2_GET_DFS_REFER_REQ
	FILE_UNIX_LINK_INFO
	FILE_DIRECTORY_INFO
	FILE_FULL_DIRECTORY_INFO
	SEARCH_ID_FULL_DIR_INFO
	FILE_BOTH_DIRECTORY_INFO
	FIND_FILE_STANDARD_INFO

Replace the trailing 1-element array with a flexible array, but leave
the existing structure padding:

	FILE_ALL_INFO
	FILE_UNIX_INFO

Remove unused structures:

	struct gea
	struct gealist

Adjust all related size calculations to match the changes to sizeof().

No machine code output differences are produced after these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/cifs/cifs_spnego.h |  2 +-
 fs/cifs/cifspdu.h     | 94 +++++++++++++++++++++----------------------
 fs/cifs/readdir.c     |  6 +--
 fs/cifs/smb2pdu.c     |  4 +-
 fs/cifs/smb2pdu.h     |  2 +-
 5 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/fs/cifs/cifs_spnego.h b/fs/cifs/cifs_spnego.h
index 7f102ffeb675..e4d751b0c812 100644
--- a/fs/cifs/cifs_spnego.h
+++ b/fs/cifs/cifs_spnego.h
@@ -24,7 +24,7 @@ struct cifs_spnego_msg {
 	uint32_t	flags;
 	uint32_t	sesskey_len;
 	uint32_t	secblob_len;
-	uint8_t		data[1];
+	uint8_t		data[];
 };
 
 #ifdef __KERNEL__
diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index add73be4902c..445e3eaebcc1 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -562,7 +562,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;
 		__le32 Capabilities;	/* see below */
 		__le16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 		/* STRING NativeOS */
 		/* STRING NativeLanMan */
 	} __attribute__((packed)) req;	/* NTLM request format (with
@@ -582,7 +582,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;	/* see below */
 		__le32 Capabilities;
 		__le16 ByteCount;
-		unsigned char CaseInsensitivePassword[1];     /* followed by: */
+		unsigned char CaseInsensitivePassword[];     /* followed by: */
 		/* unsigned char * CaseSensitivePassword; */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
@@ -599,7 +599,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 Action;	/* see below */
 		__le16 SecurityBlobLength;
 		__u16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 /*      unsigned char  * NativeOS;      */
 /*	unsigned char  * NativeLanMan;  */
 /*      unsigned char  * PrimaryDomain; */
@@ -618,7 +618,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 PasswordLength;
 		__u32 Reserved; /* encrypt key len and offset */
 		__le16 ByteCount;
-		unsigned char AccountPassword[1];	/* followed by */
+		unsigned char AccountPassword[];	/* followed by */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
 		/* STRING NativeOS */
@@ -632,7 +632,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 AndXOffset;
 		__le16 Action;	/* see below */
 		__u16 ByteCount;
-		unsigned char NativeOS[1];	/* followed by */
+		unsigned char NativeOS[];	/* followed by */
 /*	unsigned char * NativeLanMan; */
 /*      unsigned char * PrimaryDomain; */
 	} __attribute__((packed)) old_resp; /* pre-NTLM (LANMAN2.1) response */
@@ -693,7 +693,7 @@ typedef struct smb_com_tconx_req {
 	__le16 Flags;		/* see below */
 	__le16 PasswordLength;
 	__le16 ByteCount;
-	unsigned char Password[1];	/* followed by */
+	unsigned char Password[];	/* followed by */
 /* STRING Path    *//* \\server\share name */
 	/* STRING Service */
 } __attribute__((packed)) TCONX_REQ;
@@ -705,7 +705,7 @@ typedef struct smb_com_tconx_rsp {
 	__le16 AndXOffset;
 	__le16 OptionalSupport;	/* see below */
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP;
 
@@ -718,7 +718,7 @@ typedef struct smb_com_tconx_rsp_ext {
 	__le32 MaximalShareAccessRights;
 	__le32 GuestMaximalShareAccessRights;
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP_EXT;
 
@@ -755,14 +755,14 @@ typedef struct smb_com_echo_req {
 	struct	smb_hdr hdr;
 	__le16	EchoCount;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_REQ;
 
 typedef struct smb_com_echo_rsp {
 	struct	smb_hdr hdr;
 	__le16	SequenceNumber;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_RSP;
 
 typedef struct smb_com_logoff_andx_req {
@@ -862,7 +862,7 @@ typedef struct smb_com_open_req {	/* also handles create */
 	__le32 ImpersonationLevel;
 	__u8 SecurityFlags;
 	__le16 ByteCount;
-	char fileName[1];
+	char fileName[];
 } __attribute__((packed)) OPEN_REQ;
 
 /* open response: oplock levels */
@@ -937,7 +937,7 @@ typedef struct smb_com_openx_req {
 	__le32 Timeout;
 	__le32 Reserved;
 	__le16  ByteCount;  /* file name follows */
-	char   fileName[1];
+	char   fileName[];
 } __attribute__((packed)) OPENX_REQ;
 
 typedef struct smb_com_openx_rsp {
@@ -1085,7 +1085,7 @@ typedef struct smb_com_lock_req {
 	__le16 NumberOfUnlocks;
 	__le16 NumberOfLocks;
 	__le16 ByteCount;
-	LOCKING_ANDX_RANGE Locks[1];
+	LOCKING_ANDX_RANGE Locks[];
 } __attribute__((packed)) LOCK_REQ;
 
 /* lock type */
@@ -1114,7 +1114,7 @@ typedef struct smb_com_rename_req {
 	__le16 SearchAttributes;	/* target file attributes */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) RENAME_REQ;
@@ -1134,7 +1134,7 @@ typedef struct smb_com_copy_req {
 	__le16 Flags;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName string */
 } __attribute__((packed)) COPY_REQ;
@@ -1144,7 +1144,7 @@ typedef struct smb_com_copy_rsp {
 	__le16 CopyCount;    /* number of files copied */
 	__u16 ByteCount;    /* may be zero */
 	__u8 BufferFormat;  /* 0x04 - only present if errored file follows */
-	unsigned char ErrorFileName[1]; /* only present if error in copy */
+	unsigned char ErrorFileName[]; /* only present if error in copy */
 } __attribute__((packed)) COPY_RSP;
 
 #define CREATE_HARD_LINK		0x103
@@ -1158,7 +1158,7 @@ typedef struct smb_com_nt_rename_req {	/* A5 - also used for create hardlink */
 	__le32 ClusterCount;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) NT_RENAME_REQ;
@@ -1173,7 +1173,7 @@ typedef struct smb_com_delete_file_req {
 	__le16 SearchAttributes;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) DELETE_FILE_REQ;
 
 typedef struct smb_com_delete_file_rsp {
@@ -1185,7 +1185,7 @@ typedef struct smb_com_delete_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) DELETE_DIRECTORY_REQ;
 
 typedef struct smb_com_delete_directory_rsp {
@@ -1197,7 +1197,7 @@ typedef struct smb_com_create_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) CREATE_DIRECTORY_REQ;
 
 typedef struct smb_com_create_directory_rsp {
@@ -1209,7 +1209,7 @@ typedef struct smb_com_query_information_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;	/* 1 + namelen + 1 */
 	__u8 BufferFormat;      /* 4 = ASCII */
-	unsigned char FileName[1];
+	unsigned char FileName[];
 } __attribute__((packed)) QUERY_INFORMATION_REQ;
 
 typedef struct smb_com_query_information_rsp {
@@ -1229,7 +1229,7 @@ typedef struct smb_com_setattr_req {
 	__le16 reserved[5]; /* must be zero */
 	__u16  ByteCount;
 	__u8   BufferFormat; /* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) SETATTR_REQ;
 
 typedef struct smb_com_setattr_rsp {
@@ -1311,7 +1311,7 @@ typedef struct smb_com_transaction_ioctl_req {
 	__u8 IsRootFlag; /* 1 = apply command to root of share (must be DFS) */
 	__le16 ByteCount;
 	__u8 Pad[3];
-	__u8 Data[1];
+	__u8 Data[];
 } __attribute__((packed)) TRANSACT_IOCTL_REQ;
 
 typedef struct smb_com_transaction_compr_ioctl_req {
@@ -1430,7 +1430,7 @@ typedef struct smb_com_transaction_change_notify_req {
 	__u8 Reserved2;
 	__le16 ByteCount;
 /*	__u8 Pad[3];*/
-/*	__u8 Data[1];*/
+/*	__u8 Data[];*/
 } __attribute__((packed)) TRANSACT_CHANGE_NOTIFY_REQ;
 
 /* BB eventually change to use generic ntransact rsp struct
@@ -1519,7 +1519,7 @@ struct cifs_quota_data {
 	__u64	space_used;
 	__u64	soft_limit;
 	__u64	hard_limit;
-	char	sid[1];  /* variable size? */
+	char	sid[];  /* variable size? */
 } __attribute__((packed));
 
 /* quota sub commands */
@@ -1671,7 +1671,7 @@ typedef struct smb_com_transaction2_qpi_req {
 	__u8 Pad;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_QPI_REQ;
 
 typedef struct smb_com_transaction2_qpi_rsp {
@@ -1704,7 +1704,7 @@ typedef struct smb_com_transaction2_spi_req {
 	__u16 Pad1;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_SPI_REQ;
 
 typedef struct smb_com_transaction2_spi_rsp {
@@ -1809,7 +1809,7 @@ typedef struct smb_com_transaction2_ffirst_req {
 	__le16 SearchFlags;
 	__le16 InformationLevel;
 	__le32 SearchStorageType;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_FFIRST_REQ;
 
 typedef struct smb_com_transaction2_ffirst_rsp {
@@ -2020,7 +2020,7 @@ typedef struct smb_com_transaction2_get_dfs_refer_req {
 				   perhaps?) followed by one byte pad - doesn't
 				   seem to matter though */
 	__le16 MaxReferralLevel;
-	char RequestFileName[1];
+	char RequestFileName[];
 } __attribute__((packed)) TRANSACTION2_GET_DFS_REFER_REQ;
 
 #define DFS_VERSION cpu_to_le16(0x0003)
@@ -2049,7 +2049,7 @@ struct get_dfs_referral_rsp {
 	__le16 PathConsumed;
 	__le16 NumberOfReferrals;
 	__le32 DFSFlags;
-	REFERRAL3 referrals[1];	/* array of level 3 dfs_referral structures */
+	REFERRAL3 referrals[];	/* array of level 3 dfs_referral structures */
 	/* followed by the strings pointed to by the referral structures */
 } __packed;
 
@@ -2284,7 +2284,10 @@ typedef struct { /* data block encoding of response to level 263 QPathInfo */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_ALL_INFO;	/* level 0x107 QPathInfo */
 
 typedef struct {
@@ -2322,7 +2325,7 @@ typedef struct {
 } __attribute__((packed)) FILE_UNIX_BASIC_INFO;	/* level 0x200 QPathInfo */
 
 typedef struct {
-	char LinkDest[1];
+	DECLARE_FLEX_ARRAY(char, LinkDest);
 } __attribute__((packed)) FILE_UNIX_LINK_INFO;	/* level 0x201 QPathInfo */
 
 /* The following three structures are needed only for
@@ -2371,7 +2374,7 @@ struct file_end_of_file_info {
 } __attribute__((packed)); /* size info, level 0x104 for set, 0x106 for query */
 
 struct file_alt_name_info {
-	__u8   alt_name[1];
+	DECLARE_FLEX_ARRAY(__u8, alt_name);
 } __attribute__((packed));      /* level 0x0108 */
 
 struct file_stream_info {
@@ -2480,7 +2483,10 @@ typedef struct {
 	__le32 NextEntryOffset;
 	__u32 ResumeKey; /* as with FileIndex - no need to convert */
 	FILE_UNIX_BASIC_INFO basic;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_UNIX_INFO; /* level 0x202 */
 
 typedef struct {
@@ -2494,7 +2500,7 @@ typedef struct {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_DIRECTORY_INFO;   /* level 0x101 FF resp data */
 
 typedef struct {
@@ -2509,7 +2515,7 @@ typedef struct {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize; /* length of the xattrs */
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_FULL_DIRECTORY_INFO; /* level 0x102 rsp data */
 
 typedef struct {
@@ -2526,7 +2532,7 @@ typedef struct {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
 
 typedef struct {
@@ -2544,7 +2550,7 @@ typedef struct {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
 
 typedef struct {
@@ -2559,7 +2565,7 @@ typedef struct {
 	__le32 AllocationSize;
 	__le16 Attributes; /* verify not u32 */
 	__u8   FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FIND_FILE_STANDARD_INFO; /* level 0x1 FF resp data */
 
 
@@ -2569,16 +2575,6 @@ struct win_dev {
 	__le64 minor;
 } __attribute__((packed));
 
-struct gea {
-	unsigned char name_len;
-	char name[1];
-} __attribute__((packed));
-
-struct gealist {
-	unsigned long list_len;
-	struct gea list[1];
-} __attribute__((packed));
-
 struct fea {
 	unsigned char EA_flags;
 	__u8 name_len;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 2d75ba5aaa8a..ef638086d734 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -495,7 +495,7 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 		FIND_FILE_STANDARD_INFO *pfData;
 		pfData = (FIND_FILE_STANDARD_INFO *)pDirInfo;
 
-		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) +
+		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 +
 				pfData->FileNameLength;
 	} else {
 		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
@@ -513,9 +513,9 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 			 new_entry, end_of_smb, old_entry);
 		return NULL;
 	} else if (((level == SMB_FIND_FILE_INFO_STANDARD) &&
-		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) > end_of_smb))
+		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 > end_of_smb))
 		  || ((level != SMB_FIND_FILE_INFO_STANDARD) &&
-		   (new_entry + sizeof(FILE_DIRECTORY_INFO) > end_of_smb)))  {
+		   (new_entry + sizeof(FILE_DIRECTORY_INFO) + 1 > end_of_smb)))  {
 		cifs_dbg(VFS, "search entry %p extends after end of SMB %p\n",
 			 new_entry, end_of_smb);
 		return NULL;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index c304678514a5..4982f5e65e13 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -5010,10 +5010,10 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 
 	switch (srch_inf->info_level) {
 	case SMB_FIND_FILE_DIRECTORY_INFO:
-		info_buf_size = sizeof(FILE_DIRECTORY_INFO) - 1;
+		info_buf_size = sizeof(FILE_DIRECTORY_INFO);
 		break;
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
-		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
+		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO);
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
 		/* note that posix payload are variable size */
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index a5773a06aba8..2114e8a0c63a 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -371,7 +371,7 @@ struct smb2_file_id_extd_directory_info {
 	__le32 EaSize; /* EA size */
 	__le32 ReparsePointTag; /* valid if FILE_ATTR_REPARSE_POINT set in FileAttributes */
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit */
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 60 */
 
 extern char smb2_padding[7];
-- 
2.34.1

