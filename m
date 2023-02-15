Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47D69727B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjBOAIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBOAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:08:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8627D6B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:08:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ja21so11090443plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxG4N8PzLkPc0vDSLoqNXiqyTBDIgpVhsV6d59BMzSg=;
        b=WueVfT8DXeKh7+/KQGe6fIVcKtPcNA+0VGgbcSpRjiayzwcHh5vtmLWtv8TszdLcd3
         C4LjYJAIZlfyLU0/L05Dkvbmpy+6w6i5lZu9OSrzcSElBOMma1z4mgJ5H7p7qagovExs
         CLV/FtWPGPpX5bEJH4Hxgk71JaOr6HzLikNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxG4N8PzLkPc0vDSLoqNXiqyTBDIgpVhsV6d59BMzSg=;
        b=64jc3YtwZ5xPg1k71PuuGdOW5mCqBqBFC4p9bxSEVNaZAdN49lPrmTbsylOHX8yBhb
         kMXszSzGfVwERvytMZHkYQ8/2ek4NT9MTQ1/ZMxXkcR+57AqiROrFDnfB+yV68NdrlSu
         dLmheLxmqpxcFBBVgER5lkS1xTPco1TuNmrf5wlIcaDQwCbbTeZfNuyiVbt08bSXTdGc
         J7Oj+9ygoTX8BUOk+pTbK4+idsk2yagFkd1XLsCXSImEYjPuD6F16U7fe9gbmvoEcHkI
         eFtjfi442Ou46aCpEzuy0HKE54/XwSfxrHYzPAq4b7igFkKdnzyqrBCQTXrh7r8oGj36
         LQbA==
X-Gm-Message-State: AO0yUKWzeONK2IsFdeBS6ZInxkASlb6CGJ1EqRvd9NUQMFvtTHVNIW89
        Fk0mQQOeD2U2QVUMn2LwxSKaDw==
X-Google-Smtp-Source: AK7set/fyH0LeMY2/crHVF7BOUEQwZkkChzm5MJidDzHITjbmY8kKLPnM4kkaanp+hwWysH9rP7Y5g==
X-Received: by 2002:a17:903:27cb:b0:199:2f53:4d95 with SMTP id km11-20020a17090327cb00b001992f534d95mr378010plb.50.1676419721872;
        Tue, 14 Feb 2023 16:08:41 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b0019956f23fc1sm2405240plq.302.2023.02.14.16.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:08:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <sfrench@samba.org>
Cc:     Kees Cook <keescook@chromium.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] cifs: Convert struct fealist away from 1-element array
Date:   Tue, 14 Feb 2023 16:08:39 -0800
Message-Id: <20230215000832.never.591-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4124; h=from:subject:message-id; bh=jqIsD80bMJDk1XqkJe3Sc40HJ5FAdsyjBn9hLNVmULM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj7CKH+pQf5dk94hA6PFbwjKhv8ExX9aeQG46PTqh+ 9rz66KaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY+wihwAKCRCJcvTf3G3AJnznD/ 4lMO8A8/qzYQTT+7xufFPL/9ivvAOFPepsTV9c/Bumigc+7ssN7JnACYigLRJl2sMcQRdQC2SZJkIG ZSeSHO5gXR6ErRcSsZu36XzQUqg3psITGcRg5OBAeeghIx5ZYX+AutbyMfDJF7B7S3IDIG3g6Gy+5l HFUsLuNjk/9MH3o2wpBtlrFDYgW2HTjLrWmO4QFrLajU/6abkHX048DoJ+YSdU371H0U0zZ3j+WoZO rv1Na1JhgtU6vVYrAHxtfV8nohrsa1KDr8/SotfPG3oJZPsfRmSPwNmQ+yeXhmoUkDJ1FZn7X3mx5G C7Spndceqhr6t82mflXatzITG2hhnTz61rKPqnwhmnUwxET5FSB99ixjZxaj9ShLk51ya224F0pIYQ 79Im51loc5fMQE+Q7XhtFff/2wWDnJNLh5UVvhZeiXwue9ymyqFoYWxwM59fzVacmaWTOsoMgcIlgP HYlwP0XEEohKMCAQv+LFsYixCgzjOdQIvg1o62lP9uiVBxXCDAt6AHqOT+JwX2Y99GbK7u4nZwYb91 Zi3SnMMW+fyl+opsuplnLK0VICQAiIUsKl7wOKVg+v+E0Nrs9H3zsFxfFqrogXlD5UXv3PPz0lsv94 www8b0+u+rb5O8wgeG93+WVO9FJsXHajpWDxu61fcClGwUnMTfNL9b/pqm3g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

While struct fealist is defined as a "fake" flexible array (via a
1-element array), it is only used for examination of the first array
element. Walking the list is performed separately, so there is no reason
to treat the "list" member of struct fealist as anything other than a
single entry. Adjust the struct and code to match.

Additionally, struct fea uses the "name" member either as a dynamic
string, or is manually calculated from the start of the struct. Redefine
the member as a flexible array.

No machine code output differences are produced after these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/cifs/cifspdu.h |  4 ++--
 fs/cifs/cifssmb.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index 623caece2b10..add73be4902c 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -2583,7 +2583,7 @@ struct fea {
 	unsigned char EA_flags;
 	__u8 name_len;
 	__le16 value_len;
-	char name[1];
+	char name[];
 	/* optionally followed by value */
 } __attribute__((packed));
 /* flags for _FEA.fEA */
@@ -2591,7 +2591,7 @@ struct fea {
 
 struct fealist {
 	__le32 list_len;
-	struct fea list[1];
+	struct fea list;
 } __attribute__((packed));
 
 /* used to hold an arbitrary blob of data */
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 60dd4e37030a..7c587157d030 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -5787,7 +5787,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* account for ea list len */
 	list_len -= 4;
-	temp_fea = ea_response_data->list;
+	temp_fea = &ea_response_data->list;
 	temp_ptr = (char *)temp_fea;
 	while (list_len > 0) {
 		unsigned int name_len;
@@ -5902,7 +5902,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	else
 		name_len = strnlen(ea_name, 255);
 
-	count = sizeof(*parm_data) + ea_value_len + name_len;
+	count = sizeof(*parm_data) + 1 + ea_value_len + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
 	/* BB find max SMB PDU from sess */
 	pSMB->MaxDataCount = cpu_to_le16(1000);
@@ -5926,14 +5926,14 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	byte_count = 3 /* pad */  + params + count;
 	pSMB->DataCount = cpu_to_le16(count);
 	parm_data->list_len = cpu_to_le32(count);
-	parm_data->list[0].EA_flags = 0;
+	parm_data->list.EA_flags = 0;
 	/* we checked above that name len is less than 255 */
-	parm_data->list[0].name_len = (__u8)name_len;
+	parm_data->list.name_len = (__u8)name_len;
 	/* EA names are always ASCII */
 	if (ea_name)
-		strncpy(parm_data->list[0].name, ea_name, name_len);
-	parm_data->list[0].name[name_len] = 0;
-	parm_data->list[0].value_len = cpu_to_le16(ea_value_len);
+		strncpy(parm_data->list.name, ea_name, name_len);
+	parm_data->list.name[name_len] = '\0';
+	parm_data->list.value_len = cpu_to_le16(ea_value_len);
 	/* caller ensures that ea_value_len is less than 64K but
 	we need to ensure that it fits within the smb */
 
@@ -5941,7 +5941,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	     negotiated SMB buffer size BB */
 	/* if (ea_value_len > buffer_size - 512 (enough for header)) */
 	if (ea_value_len)
-		memcpy(parm_data->list[0].name+name_len+1,
+		memcpy(parm_data->list.name + name_len + 1,
 		       ea_value, ea_value_len);
 
 	pSMB->TotalDataCount = pSMB->DataCount;
-- 
2.34.1

