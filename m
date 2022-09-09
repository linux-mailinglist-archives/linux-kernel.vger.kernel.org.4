Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587F55B3C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiIIPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIIPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:42:32 -0400
Received: from p3plwbeout23-01.prod.phx3.secureserver.net (p3plsmtp23-01-2.prod.phx3.secureserver.net [68.178.252.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FACC0E79
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:42:30 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id Wg9DoxEmhjbT6Wg9Eokn8w; Fri, 09 Sep 2022 08:42:28 -0700
X-CMAE-Analysis: v=2.4 cv=IsbbzJzg c=1 sm=1 tr=0 ts=631b5ee6
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=xOM3xZuef0cA:10 a=i0EeH86SAAAA:8 a=2ZTNbuL5BFVJ4bJcZn8A:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  Wg9DoxEmhjbT6
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp04.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oWg9B-000CIx-96; Fri, 09 Sep 2022 16:42:27 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     nixiaoming@huawei.com
Cc:     chenjianguo3@huawei.com, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, wangbing6@huawei.com, wangle6@huawei.com,
        yi.zhang@huawei.com, zhongjubin@huawei.com
Subject: Re: [PATCH v3 1/2] squashfs: add the mount parameter theads=<single|multi|percpu>
Date:   Fri,  9 Sep 2022 16:44:14 +0100
Message-Id: <20220909154414.9346-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902094855.22666-2-nixiaoming@huawei.com>
References: <20220902094855.22666-2-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfOLlX32NlEMMvl7+ItVk94xt5WmJbVhmldLUu/V5tYWC+L6nvZjISGHLCXsba+8jvkIYJbCPAfo6UI4dNMyzH+JV1sVkH63PPjvQ3f8+f65bCJ4pL1UM
 dUlwdcVbkeHuW88kK4c0+pFJrW0NiCqzEgLRpQabvGSUUOuMPenJEpZBml93Dqer90PpSbr+9cG/eO1yxi2EUEaZMFjnDnh5hAA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Review comments below.

Xiaoming Ni <nixiaoming@huawei.com> wrote:
>Squashfs supports three decompression concurrency modes:
>	Single-thread mode: concurrent reads are blocked and the memory overhead
>is small.

Please wrap over 80 column line.

>	Multi-thread mode/percpu mode: reduces concurrent read blocking but
>increases memory overhead.
>
>The corresponding schema must be fixed at compile time. During mounting,
>the concurrent decompression mode cannot be adjusted based on file read
>blocking.
>
>The mount parameter theads=<single|multi|percpu> is added to select
>the concurrent decompression mode of a single SquashFS file system
>image.
>
>Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>---
> fs/squashfs/Kconfig                     | 40 ++++++++++++++++++++++----
> fs/squashfs/decompressor_multi.c        | 28 ++++++++++--------
> fs/squashfs/decompressor_multi_percpu.c | 39 +++++++++++++++----------
> fs/squashfs/decompressor_single.c       | 23 +++++++++------
> fs/squashfs/squashfs.h                  | 43 ++++++++++++++++++++++++----
> fs/squashfs/squashfs_fs_sb.h            |  3 +-
> fs/squashfs/super.c                     | 50 ++++++++++++++++++++++++++++++++-
> 7 files changed, 180 insertions(+), 46 deletions(-)
>
>diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
>index 916e78fabcaa..9c2827459f40 100644
>--- a/fs/squashfs/Kconfig
>+++ b/fs/squashfs/Kconfig
>@@ -54,9 +54,37 @@ config SQUASHFS_FILE_DIRECT
> 
> endchoice
> 
>+config SQUASHFS_DECOMP_SINGLE
>+	depends on SQUASHFS
>+	def_bool n
>+
>+config SQUASHFS_DECOMP_MULTI
>+	depends on SQUASHFS
>+	def_bool n
>+
>+config SQUASHFS_DECOMP_MULTI_PERCPU
>+	depends on SQUASHFS
>+	def_bool n
>+
>+config SQUASHFS_CHOICE_DECOMP_BY_MOUNT
>+	bool "Select the parallel decompression mode during mount"
>+	depends on SQUASHFS
>+	default n
>+	select SQUASHFS_DECOMP_SINGLE
>+	select SQUASHFS_DECOMP_MULTI
>+	select SQUASHFS_DECOMP_MULTI_PERCPU
>+	help
>+	  Compile all parallel decompression modes and specify the
>+	  decompression mode by setting "threads=" during mount.
>+
>+	  	  threads=<single|multi|percpu>

git am reports "warning: 1 line adds whitespace errors.", which is here.

[SNIP]

>diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
>index db9f12a3ea05..7b2723b77e75 100644
>--- a/fs/squashfs/decompressor_multi.c
>+++ b/fs/squashfs/decompressor_multi.c
>@@ -29,13 +29,12 @@
> #define MAX_DECOMPRESSOR	(num_online_cpus() * 2)
> 
> 
>-int squashfs_max_decompressors(void)
>+static int squashfs_max_decompressors_multi(void)

Changing the name of the function *should* be unnecessary, because
you're making it static.

> {
> 	return MAX_DECOMPRESSOR;
> }
> 
>-
>-struct squashfs_stream {
>+struct squashfs_stream_multi {

Again changing the name of the structure should be unnecessary.

This is just extra noise.

The current "diffstat" for the 3 decompression threading implementations is:

fs/squashfs/decompressor_multi.c        | 28 ++++++++++--------
fs/squashfs/decompressor_multi_percpu.c | 39 +++++++++++++++----------
fs/squashfs/decompressor_single.c       | 23 +++++++++------

But, once you get rid of this noise, it drops to

fs/squashfs/decompressor_multi.c        | 16 +++++---
fs/squashfs/decompressor_multi_percpu.c | 23 +++++++----
fs/squashfs/decompressor_single.c       | 15 ++++++--

[SNIP]

>--- a/fs/squashfs/squashfs.h
>+++ b/fs/squashfs/squashfs.h
>@@ -38,12 +38,45 @@ extern const struct squashfs_decompressor *squashfs_lookup_decompressor(int);
> extern void *squashfs_decompressor_setup(struct super_block *, unsigned short);
> 
> /* decompressor_xxx.c */

[SNIP]

>+
>+static inline void *squashfs_decompressor_create(struct squashfs_sb_info *msblk, void *comp_opts)
>+{
>+	return msblk->thread_ops->create(msblk, comp_opts);
>+}
>+
>+static inline void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
>+{
>+	msblk->thread_ops->destroy(msblk);
>+}
>+
>+static inline int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
>+				      int offset, int length, struct squashfs_page_actor *output)
>+{
>+	return msblk->thread_ops->decompress(msblk, bio, offset, length, output);
>+}
>+
>+static inline int squashfs_max_decompressors(struct squashfs_sb_info *msblk)
>+{
>+	return msblk->thread_ops->max_decompressors();
>+}

The above is the reason why you've had to rename the functions in the
decompression threading implementations.  Because you've put the new
accessors into squashfs.h which is also included by the threading
implementations which causes a name clash.

But, the correct way to avoid this clash, is to put the accessors into
a new header file, which isn't included by the decompression threading
implementations.

The following patch does this cleanup, to simplify the patch here.  It also
moves the struct squashfs_decompressor_thread_ops definition into
decompressor.h which is a better place.

Phillip

 fs/squashfs/block.c                     |  1 +
 fs/squashfs/decompressor.c              |  1 +
 fs/squashfs/decompressor.h              |  8 +++++
 fs/squashfs/decompressor_multi.c        | 28 ++++++++---------
 fs/squashfs/decompressor_multi_percpu.c | 36 +++++++++++-----------
 fs/squashfs/decompressor_single.c       | 24 +++++++--------
 fs/squashfs/squashfs.h                  | 40 -------------------------
 fs/squashfs/super.c                     |  1 +
 fs/squashfs/threading.h                 | 30 +++++++++++++++++++
 9 files changed, 85 insertions(+), 84 deletions(-)
 create mode 100644 fs/squashfs/threading.h

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 833aca92301f..9bcf7e1b64be 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -26,6 +26,7 @@
 #include "squashfs.h"
 #include "decompressor.h"
 #include "page_actor.h"
+#include "threading.h"
 
 /*
  * Returns the amount of bytes copied to the page actor.
diff --git a/fs/squashfs/decompressor.c b/fs/squashfs/decompressor.c
index d57bef91ab08..5c355fca0df5 100644
--- a/fs/squashfs/decompressor.c
+++ b/fs/squashfs/decompressor.c
@@ -18,6 +18,7 @@
 #include "decompressor.h"
 #include "squashfs.h"
 #include "page_actor.h"
+#include "threading.h"
 
 /*
  * This file (and decompressor.h) implements a decompressor framework for
diff --git a/fs/squashfs/decompressor.h b/fs/squashfs/decompressor.h
index 19ab60834389..5b5ec4828930 100644
--- a/fs/squashfs/decompressor.h
+++ b/fs/squashfs/decompressor.h
@@ -24,6 +24,14 @@ struct squashfs_decompressor {
 	int	supported;
 };
 
+struct squashfs_decompressor_thread_ops {
+	void * (*create)(struct squashfs_sb_info *msblk, void *comp_opts);
+	void (*destroy)(struct squashfs_sb_info *msblk);
+	int (*decompress)(struct squashfs_sb_info *msblk, struct bio *bio,
+			  int offset, int length, struct squashfs_page_actor *output);
+	int (*max_decompressors)(void);
+};
+
 static inline void *squashfs_comp_opts(struct squashfs_sb_info *msblk,
 							void *buff, int length)
 {
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index 7b2723b77e75..eb25432bd149 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -29,12 +29,12 @@
 #define MAX_DECOMPRESSOR	(num_online_cpus() * 2)
 
 
-static int squashfs_max_decompressors_multi(void)
+static int squashfs_max_decompressors(void)
 {
 	return MAX_DECOMPRESSOR;
 }
 
-struct squashfs_stream_multi {
+struct squashfs_stream {
 	void			*comp_opts;
 	struct list_head	strm_list;
 	struct mutex		mutex;
@@ -50,7 +50,7 @@ struct decomp_stream {
 
 
 static void put_decomp_stream(struct decomp_stream *decomp_strm,
-				struct squashfs_stream_multi *stream)
+				struct squashfs_stream *stream)
 {
 	mutex_lock(&stream->mutex);
 	list_add(&decomp_strm->list, &stream->strm_list);
@@ -58,10 +58,10 @@ static void put_decomp_stream(struct decomp_stream *decomp_strm,
 	wake_up(&stream->wait);
 }
 
-static void *squashfs_decompressor_create_multi(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 				void *comp_opts)
 {
-	struct squashfs_stream_multi *stream;
+	struct squashfs_stream *stream;
 	struct decomp_stream *decomp_strm = NULL;
 	int err = -ENOMEM;
 
@@ -102,9 +102,9 @@ static void *squashfs_decompressor_create_multi(struct squashfs_sb_info *msblk,
 }
 
 
-static void squashfs_decompressor_destroy_multi(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream_multi *stream = msblk->stream;
+	struct squashfs_stream *stream = msblk->stream;
 	if (stream) {
 		struct decomp_stream *decomp_strm;
 
@@ -124,7 +124,7 @@ static void squashfs_decompressor_destroy_multi(struct squashfs_sb_info *msblk)
 
 
 static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
-					struct squashfs_stream_multi *stream)
+					struct squashfs_stream *stream)
 {
 	struct decomp_stream *decomp_strm;
 
@@ -179,12 +179,12 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 }
 
 
-static int squashfs_decompress_multi(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
 	int res;
-	struct squashfs_stream_multi *stream = msblk->stream;
+	struct squashfs_stream *stream = msblk->stream;
 	struct decomp_stream *decomp_stream = get_decomp_stream(msblk, stream);
 	res = msblk->decompressor->decompress(msblk, decomp_stream->stream,
 		bio, offset, length, output);
@@ -196,8 +196,8 @@ static int squashfs_decompress_multi(struct squashfs_sb_info *msblk, struct bio
 }
 
 const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi = {
-	.create = squashfs_decompressor_create_multi,
-	.destroy = squashfs_decompressor_destroy_multi,
-	.decompress = squashfs_decompress_multi,
-	.max_decompressors = squashfs_max_decompressors_multi,
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
 };
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index e24455a7b04d..1dfadf76ed9a 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -20,19 +20,19 @@
  * variables, one thread per cpu core.
  */
 
-struct squashfs_stream_percpu {
+struct squashfs_stream {
 	void			*stream;
 	local_lock_t	lock;
 };
 
-static void *squashfs_decompressor_create_percpu(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
-	struct squashfs_stream_percpu *stream;
-	struct squashfs_stream_percpu __percpu *percpu;
+	struct squashfs_stream *stream;
+	struct squashfs_stream __percpu *percpu;
 	int err, cpu;
 
-	percpu = alloc_percpu(struct squashfs_stream_percpu);
+	percpu = alloc_percpu(struct squashfs_stream);
 	if (percpu == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -59,11 +59,11 @@ static void *squashfs_decompressor_create_percpu(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-static void squashfs_decompressor_destroy_percpu(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream_percpu __percpu *percpu =
-			(struct squashfs_stream_percpu __percpu *) msblk->stream;
-	struct squashfs_stream_percpu *stream;
+	struct squashfs_stream __percpu *percpu =
+			(struct squashfs_stream __percpu *) msblk->stream;
+	struct squashfs_stream *stream;
 	int cpu;
 
 	if (msblk->stream) {
@@ -75,12 +75,12 @@ static void squashfs_decompressor_destroy_percpu(struct squashfs_sb_info *msblk)
 	}
 }
 
-static int squashfs_decompress_percpu(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	int offset, int length, struct squashfs_page_actor *output)
 {
-	struct squashfs_stream_percpu *stream;
-	struct squashfs_stream_percpu __percpu *percpu =
-			(struct squashfs_stream_percpu __percpu *) msblk->stream;
+	struct squashfs_stream *stream;
+	struct squashfs_stream __percpu *percpu =
+			(struct squashfs_stream __percpu *) msblk->stream;
 	int res;
 
 	local_lock(&percpu->lock);
@@ -98,14 +98,14 @@ static int squashfs_decompress_percpu(struct squashfs_sb_info *msblk, struct bio
 	return res;
 }
 
-static int squashfs_max_decompressors_percpu(void)
+static int squashfs_max_decompressors(void)
 {
 	return num_possible_cpus();
 }
 
 const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu = {
-	.create = squashfs_decompressor_create_percpu,
-	.destroy = squashfs_decompressor_destroy_percpu,
-	.decompress = squashfs_decompress_percpu,
-	.max_decompressors = squashfs_max_decompressors_percpu,
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
 };
diff --git a/fs/squashfs/decompressor_single.c b/fs/squashfs/decompressor_single.c
index 41449de0ea4c..6f161887710b 100644
--- a/fs/squashfs/decompressor_single.c
+++ b/fs/squashfs/decompressor_single.c
@@ -19,15 +19,15 @@
  * decompressor framework
  */
 
-struct squashfs_stream_single {
+struct squashfs_stream {
 	void		*stream;
 	struct mutex	mutex;
 };
 
-static void *squashfs_decompressor_create_single(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
-	struct squashfs_stream_single *stream;
+	struct squashfs_stream *stream;
 	int err = -ENOMEM;
 
 	stream = kmalloc(sizeof(*stream), GFP_KERNEL);
@@ -49,9 +49,9 @@ static void *squashfs_decompressor_create_single(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-static void squashfs_decompressor_destroy_single(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream_single *stream = msblk->stream;
+	struct squashfs_stream *stream = msblk->stream;
 
 	if (stream) {
 		msblk->decompressor->free(stream->stream);
@@ -59,12 +59,12 @@ static void squashfs_decompressor_destroy_single(struct squashfs_sb_info *msblk)
 	}
 }
 
-static int squashfs_decompress_single(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
 	int res;
-	struct squashfs_stream_single *stream = msblk->stream;
+	struct squashfs_stream *stream = msblk->stream;
 
 	mutex_lock(&stream->mutex);
 	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
@@ -78,14 +78,14 @@ static int squashfs_decompress_single(struct squashfs_sb_info *msblk, struct bio
 	return res;
 }
 
-static int squashfs_max_decompressors_single(void)
+static int squashfs_max_decompressors(void)
 {
 	return 1;
 }
 
 const struct squashfs_decompressor_thread_ops squashfs_decompressor_single = {
-	.create = squashfs_decompressor_create_single,
-	.destroy = squashfs_decompressor_destroy_single,
-	.decompress = squashfs_decompress_single,
-	.max_decompressors = squashfs_max_decompressors_single,
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
 };
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 9a383ad0dae0..9ba9e95440f8 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -37,46 +37,6 @@ extern void *squashfs_read_table(struct super_block *, u64, int);
 extern const struct squashfs_decompressor *squashfs_lookup_decompressor(int);
 extern void *squashfs_decompressor_setup(struct super_block *, unsigned short);
 
-/* decompressor_xxx.c */
-
-struct squashfs_decompressor_thread_ops {
-	void * (*create)(struct squashfs_sb_info *msblk, void *comp_opts);
-	void (*destroy)(struct squashfs_sb_info *msblk);
-	int (*decompress)(struct squashfs_sb_info *msblk, struct bio *bio,
-			  int offset, int length, struct squashfs_page_actor *output);
-	int (*max_decompressors)(void);
-};
-
-#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
-extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_single;
-#endif
-#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
-extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi;
-#endif
-#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
-extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu;
-#endif
-
-static inline void *squashfs_decompressor_create(struct squashfs_sb_info *msblk, void *comp_opts)
-{
-	return msblk->thread_ops->create(msblk, comp_opts);
-}
-
-static inline void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
-{
-	msblk->thread_ops->destroy(msblk);
-}
-
-static inline int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
-				      int offset, int length, struct squashfs_page_actor *output)
-{
-	return msblk->thread_ops->decompress(msblk, bio, offset, length, output);
-}
-
-static inline int squashfs_max_decompressors(struct squashfs_sb_info *msblk)
-{
-	return msblk->thread_ops->max_decompressors();
-}
 /* export.c */
 extern __le64 *squashfs_read_inode_lookup_table(struct super_block *, u64, u64,
 				unsigned int);
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index fd4e70d45f3c..d7dc4b304aa0 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -36,6 +36,7 @@
 #include "squashfs.h"
 #include "decompressor.h"
 #include "xattr.h"
+#include "threading.h"
 
 static struct file_system_type squashfs_fs_type;
 static const struct super_operations squashfs_super_ops;
diff --git a/fs/squashfs/threading.h b/fs/squashfs/threading.h
new file mode 100644
index 000000000000..bd06519fb8b9
--- /dev/null
+++ b/fs/squashfs/threading.h
@@ -0,0 +1,30 @@
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_single;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu;
+#endif
+
+static inline void *squashfs_decompressor_create(struct squashfs_sb_info *msblk, void *comp_opts)
+{
+	return msblk->thread_ops->create(msblk, comp_opts);
+}
+
+static inline void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+{
+	msblk->thread_ops->destroy(msblk);
+}
+
+static inline int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+				      int offset, int length, struct squashfs_page_actor *output)
+{
+	return msblk->thread_ops->decompress(msblk, bio, offset, length, output);
+}
+
+static inline int squashfs_max_decompressors(struct squashfs_sb_info *msblk)
+{
+	return msblk->thread_ops->max_decompressors();
+}
-- 
2.35.1

