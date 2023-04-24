Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5276E56DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDRBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjDRBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41295B97
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 188-20020a250ac5000000b00b9265c9a5e9so2183530ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782092; x=1684374092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLfNH8wOaoEhBmLooOhZO4y32d1iMom08eY0cFO8TR0=;
        b=WjKoP43zShmBluCRjRG7SpJRr6ZhcFjGdtCDccumEdmZPIzgFTJvIKad4FYUIjjQQy
         IplrWk3NdRdH2gDDLJQ9Cx/UvfS1qSwkngDqd21ylbmG4ukfCRinSmNNAs5uppGzVJLG
         lpzuh+saSdzIC/lLpNoMzuaoBLoXD19zIu7i6cCa28+pGHuAQbBcT10P4y35gFo66XQa
         Tnn9wbyumgtkRMoHf71AAl1+0l3ZdUh4BWT0RNrOjfa3KXsL2/sdfWUPFVrKfqF59nvb
         JuM8Zm1GDKLnP4FRMd0bLhe8vn0smcB/2wdsoJsfUhL4Z5/rqi8pn3H217Z4nqyfNjCk
         TSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782092; x=1684374092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLfNH8wOaoEhBmLooOhZO4y32d1iMom08eY0cFO8TR0=;
        b=RRTfa6Vcd3Y76yBLkVunQ58yjbMg6OcN2xkEgoqnvhQ2COGJUZH2I3HXDI4ymLn+4H
         LCWeIv8TC7OESbRcZDt8I60srhHgvk7qehAFynKrxGGoMOYtJ2tBPGeX1BGWjY0MM4G/
         zcC+SAD8yAuSQy2EL7nkquXJucrCoAjeTbF+jPJarE9vk0FpL2AcQudzoUY40mlg7p2A
         6TXyKcrBq2EcswZungqWpllJx61QGaVr+WwSd0/gjzyay7rIYfF07C4ZujQ1rf1lXEic
         nQUJDdo575x0mxd7pOzg1XLUUzwrf9qRxvmBU0Sw6XQqjtOkTTSMRWAzhtWcymfgaXNa
         LIgw==
X-Gm-Message-State: AAQBX9fqdwbK723BqWBzdPNXe5ySo/zdas+PFpVZMrK8BjkXux0RiNpV
        aRzqjCzaYA9bIxLKs91fkT3vZ2ukWPk=
X-Google-Smtp-Source: AKy350ZFWi1/rz2iUYQDDITIMq4pvfy+q1dsB6RG635Ep9uEFEuOKaLHWxdFW4DJWTE+80pH5vnhyBiQBOM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a05:690c:d91:b0:54f:e88d:79ba with SMTP id
 da17-20020a05690c0d9100b0054fe88d79bamr9714213ywb.5.1681782091925; Mon, 17
 Apr 2023 18:41:31 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:18 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-19-drosen@google.com>
Subject: [RFC PATCH v3 18/37] fuse-bpf: support readdir
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds backing support for FUSE_READDIR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c         | 194 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   6 ++
 fs/fuse/readdir.c         |   5 +
 include/uapi/linux/fuse.h |   6 ++
 4 files changed, 211 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c7709a880e9c..2908c231a695 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1669,6 +1669,200 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_read_args {
+	struct fuse_read_in in;
+	struct fuse_read_out out;
+	struct fuse_buffer buffer;
+};
+
+static int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_args *args,
+				      struct file *file, struct dir_context *ctx,
+				      bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = ff->nodeid,
+			.opcode = FUSE_READDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+	};
+
+	args->in = (struct fuse_read_in) {
+		.fh = ff->fh,
+		.offset = ctx->pos,
+		.size = PAGE_SIZE,
+	};
+
+	*force_again = false;
+	*allow_force = true;
+	return 0;
+}
+
+static int fuse_readdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_read_args *args,
+				       struct file *file, struct dir_context *ctx,
+				       bool *force_again, bool *allow_force, bool is_continued)
+{
+	u8 *page = (u8 *)__get_free_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	fa->flags = FUSE_BPF_OUT_ARGVAR;
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->out),
+		.value = &args->out,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.is_buffer = true,
+		.buffer = &args->buffer,
+	};
+	args->out = (struct fuse_read_out) {
+		.again = 0,
+		.offset = 0,
+	};
+	args->buffer = (struct fuse_buffer) {
+		.data = page,
+		.size = PAGE_SIZE,
+		.alloc_size = PAGE_SIZE,
+		.max_size = PAGE_SIZE,
+		.flags = BPF_FUSE_VARIABLE_SIZE,
+	};
+
+	return 0;
+}
+
+struct fusebpf_ctx {
+	struct dir_context ctx;
+	u8 *addr;
+	size_t offset;
+};
+
+static bool filldir(struct dir_context *ctx, const char *name, int namelen,
+		   loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct fusebpf_ctx *ec = container_of(ctx, struct fusebpf_ctx, ctx);
+	struct fuse_dirent *fd = (struct fuse_dirent *)(ec->addr + ec->offset);
+
+	if (ec->offset + sizeof(struct fuse_dirent) + namelen > PAGE_SIZE)
+		return false;
+
+	*fd = (struct fuse_dirent) {
+		.ino = ino,
+		.off = offset,
+		.namelen = namelen,
+		.type = d_type,
+	};
+
+	memcpy(fd->name, name, namelen);
+	ec->offset += FUSE_DIRENT_SIZE(fd);
+
+	return true;
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct dir_context *ctx)
+{
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+			return -EIO;
+
+		ctx->pos = dirent->off;
+		if (!dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
+				dirent->type))
+			break;
+
+		buf += reclen;
+		nbytes -= reclen;
+	}
+
+	return 0;
+}
+
+static int fuse_readdir_backing(struct bpf_fuse_args *fa, int *out,
+				struct file *file, struct dir_context *ctx,
+				bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct fusebpf_ctx ec;
+
+	ec = (struct fusebpf_ctx) {
+		.ctx.actor = filldir,
+		.ctx.pos = ctx->pos,
+		.addr = fa->out_args[1].buffer->data,
+	};
+
+	if (!ec.addr)
+		return -ENOMEM;
+
+	if (!is_continued)
+		backing_dir->f_pos = file->f_pos;
+
+	*out = iterate_dir(backing_dir, &ec.ctx);
+	if (ec.offset == 0)
+		*allow_force = false;
+	fa->out_args[1].buffer->size = ec.offset;
+
+	fro->offset = ec.ctx.pos;
+	fro->again = false;
+
+	return *out;
+}
+
+static int fuse_readdir_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct file *file, struct dir_context *ctx,
+				 bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+
+	*out = parse_dirfile(fa->out_args[1].buffer->data, fa->out_args[1].buffer->size, ctx);
+	*force_again = !!fro->again;
+	if (*force_again && !*allow_force)
+		*out = -EINVAL;
+
+	ctx->pos = fro->offset;
+	backing_dir->f_pos = fro->offset;
+
+	free_page((unsigned long)fa->out_args[1].buffer->data);
+	return *out;
+}
+
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	int ret;
+	bool allow_force;
+	bool force_again = false;
+	bool is_continued = false;
+
+again:
+	ret = bpf_fuse_backing(inode, struct fuse_read_args, out,
+			       fuse_readdir_initialize_in, fuse_readdir_initialize_out,
+			       fuse_readdir_backing, fuse_readdir_finalize,
+			       file, ctx, &force_again, &allow_force, is_continued);
+	if (force_again && *out >= 0) {
+		is_continued = true;
+		goto again;
+	}
+
+	return ret;
+}
+
 static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4bc070b81ac2..fb3a77b79b0f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1419,6 +1419,7 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
@@ -1489,6 +1490,11 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 {
 	return 0;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..cc6548f314f2 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -20,6 +20,8 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 
 	if (!fc->do_readdirplus)
 		return false;
+	if (fi->nodeid == 0)
+		return false;
 	if (!fc->readdirplus_auto)
 		return true;
 	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
@@ -582,6 +584,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_readdir(&err, inode, file, ctx))
+		return err;
+
 	mutex_lock(&ff->readdir.lock);
 
 	err = UNCACHED;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index dbfc8d501bcb..e779064f5fad 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -748,6 +748,12 @@ struct fuse_read_in {
 	uint32_t	padding;
 };
 
+struct fuse_read_out {
+	uint64_t	offset;
+	uint32_t	again;
+	uint32_t	padding;
+};
+
 // This is likely not what we want
 struct fuse_read_iter_out {
 	uint64_t ret;
-- 
2.40.0.634.g4ca3ef3211-goog

