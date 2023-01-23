Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DA678A17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjAWWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjAWWAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:00:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5059CA;
        Mon, 23 Jan 2023 13:59:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P13tK0HsSz4y0R;
        Tue, 24 Jan 2023 08:59:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674511193;
        bh=qQtAsaxbZzNYNeupHyJwSGc3ljHHmhw1HnYu4+UV2QQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NHfsdWtqFq/mxB1D13ml3ivpn4rff23atH+AOBeW8/V9xkwijqClTzlf2HJkX7QNB
         OeHwQUrJplfFsgqCZxq5RSwGOKodbviRa0hmvW3YZnCeUQ+ZQyTOtrnJiwcAeFIwh7
         dN496UKwWXvDPSejL/EBIXFsnqZX5zc4Ve5MBhDsNS6nzdbev4Ehl6aQpv2LJmKzmu
         kvp5yYQImTTvymDUBKegbFb2d5BKqEpt9XkPuI15+3UYqv6qOQNNT2aMzAZ/Q8Ept4
         KwrCZPJmXCHOaKKeQiV1FbGmdKuZe9nBUXRe08SRObeMnuKHkXgJ8/vlu4RvwSfh+3
         8lo59z6w7Bw4A==
Date:   Tue, 24 Jan 2023 08:59:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the zonefs tree with the vfs-idmapping
 tree
Message-ID: <20230124085951.59eb8da3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/52Nzbp3idqTfgnppX/j5PCf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/52Nzbp3idqTfgnppX/j5PCf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the zonefs tree got a conflict in:

  fs/zonefs/super.c

between commits:

  c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
  f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
  f861646a6562 ("quota: port to mnt_idmap")

from the vfs-idmapping tree and commits:

  4008e2a0b01a ("zonefs: Reorganize code")
  d207794ababe ("zonefs: Dynamically create file inodes when needed")

from the zonefs tree.

This is a bit of a mess :-(

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/zonefs/super.c
index 72ef97320b99,010b53545e5b..000000000000
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@@ -526,85 -402,145 +402,145 @@@ void __zonefs_io_error(struct inode *in
  	memalloc_noio_restore(noio_flag);
  }
 =20
- static void zonefs_io_error(struct inode *inode, bool write)
+ static struct kmem_cache *zonefs_inode_cachep;
+=20
+ static struct inode *zonefs_alloc_inode(struct super_block *sb)
  {
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+ 	struct zonefs_inode_info *zi;
+=20
+ 	zi =3D alloc_inode_sb(sb, zonefs_inode_cachep, GFP_KERNEL);
+ 	if (!zi)
+ 		return NULL;
+=20
+ 	inode_init_once(&zi->i_vnode);
+ 	mutex_init(&zi->i_truncate_mutex);
+ 	zi->i_wr_refcnt =3D 0;
 =20
- 	mutex_lock(&zi->i_truncate_mutex);
- 	__zonefs_io_error(inode, write);
- 	mutex_unlock(&zi->i_truncate_mutex);
+ 	return &zi->i_vnode;
  }
 =20
- static int zonefs_file_truncate(struct inode *inode, loff_t isize)
+ static void zonefs_free_inode(struct inode *inode)
  {
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	loff_t old_isize;
- 	enum req_op op;
- 	int ret =3D 0;
+ 	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
+ }
 =20
- 	/*
- 	 * Only sequential zone files can be truncated and truncation is allowed
- 	 * only down to a 0 size, which is equivalent to a zone reset, and to
- 	 * the maximum file size, which is equivalent to a zone finish.
- 	 */
- 	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
- 		return -EPERM;
+ /*
+  * File system stat.
+  */
+ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
+ {
+ 	struct super_block *sb =3D dentry->d_sb;
+ 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+ 	enum zonefs_ztype t;
 =20
- 	if (!isize)
- 		op =3D REQ_OP_ZONE_RESET;
- 	else if (isize =3D=3D zi->i_max_size)
- 		op =3D REQ_OP_ZONE_FINISH;
+ 	buf->f_type =3D ZONEFS_MAGIC;
+ 	buf->f_bsize =3D sb->s_blocksize;
+ 	buf->f_namelen =3D ZONEFS_NAME_MAX;
+=20
+ 	spin_lock(&sbi->s_lock);
+=20
+ 	buf->f_blocks =3D sbi->s_blocks;
+ 	if (WARN_ON(sbi->s_used_blocks > sbi->s_blocks))
+ 		buf->f_bfree =3D 0;
  	else
- 		return -EPERM;
+ 		buf->f_bfree =3D buf->f_blocks - sbi->s_used_blocks;
+ 	buf->f_bavail =3D buf->f_bfree;
+=20
+ 	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {
+ 		if (sbi->s_zgroup[t].g_nr_zones)
+ 			buf->f_files +=3D sbi->s_zgroup[t].g_nr_zones + 1;
+ 	}
+ 	buf->f_ffree =3D 0;
 =20
- 	inode_dio_wait(inode);
+ 	spin_unlock(&sbi->s_lock);
 =20
- 	/* Serialize against page faults */
- 	filemap_invalidate_lock(inode->i_mapping);
+ 	buf->f_fsid =3D uuid_to_fsid(sbi->s_uuid.b);
 =20
- 	/* Serialize against zonefs_iomap_begin() */
- 	mutex_lock(&zi->i_truncate_mutex);
+ 	return 0;
+ }
 =20
- 	old_isize =3D i_size_read(inode);
- 	if (isize =3D=3D old_isize)
- 		goto unlock;
+ enum {
+ 	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
+ 	Opt_explicit_open, Opt_err,
+ };
 =20
- 	ret =3D zonefs_zone_mgmt(inode, op);
- 	if (ret)
- 		goto unlock;
+ static const match_table_t tokens =3D {
+ 	{ Opt_errors_ro,	"errors=3Dremount-ro"},
+ 	{ Opt_errors_zro,	"errors=3Dzone-ro"},
+ 	{ Opt_errors_zol,	"errors=3Dzone-offline"},
+ 	{ Opt_errors_repair,	"errors=3Drepair"},
+ 	{ Opt_explicit_open,	"explicit-open" },
+ 	{ Opt_err,		NULL}
+ };
 =20
- 	/*
- 	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,
- 	 * take care of open zones.
- 	 */
- 	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
- 		/*
- 		 * Truncating a zone to EMPTY or FULL is the equivalent of
- 		 * closing the zone. For a truncation to 0, we need to
- 		 * re-open the zone to ensure new writes can be processed.
- 		 * For a truncation to the maximum file size, the zone is
- 		 * closed and writes cannot be accepted anymore, so clear
- 		 * the open flag.
- 		 */
- 		if (!isize)
- 			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
- 		else
- 			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+ static int zonefs_parse_options(struct super_block *sb, char *options)
+ {
+ 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+ 	substring_t args[MAX_OPT_ARGS];
+ 	char *p;
+=20
+ 	if (!options)
+ 		return 0;
+=20
+ 	while ((p =3D strsep(&options, ",")) !=3D NULL) {
+ 		int token;
+=20
+ 		if (!*p)
+ 			continue;
+=20
+ 		token =3D match_token(p, tokens, args);
+ 		switch (token) {
+ 		case Opt_errors_ro:
+ 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
+ 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_RO;
+ 			break;
+ 		case Opt_errors_zro:
+ 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
+ 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_ZRO;
+ 			break;
+ 		case Opt_errors_zol:
+ 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
+ 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_ZOL;
+ 			break;
+ 		case Opt_errors_repair:
+ 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
+ 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_REPAIR;
+ 			break;
+ 		case Opt_explicit_open:
+ 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_EXPLICIT_OPEN;
+ 			break;
+ 		default:
+ 			return -EINVAL;
+ 		}
  	}
 =20
- 	zonefs_update_stats(inode, isize);
- 	truncate_setsize(inode, isize);
- 	zi->i_wpoffset =3D isize;
- 	zonefs_account_active(inode);
+ 	return 0;
+ }
+=20
+ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
+ {
+ 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(root->d_sb);
+=20
+ 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO)
+ 		seq_puts(seq, ",errors=3Dremount-ro");
+ 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO)
+ 		seq_puts(seq, ",errors=3Dzone-ro");
+ 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL)
+ 		seq_puts(seq, ",errors=3Dzone-offline");
+ 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_REPAIR)
+ 		seq_puts(seq, ",errors=3Drepair");
 =20
- unlock:
- 	mutex_unlock(&zi->i_truncate_mutex);
- 	filemap_invalidate_unlock(inode->i_mapping);
+ 	return 0;
+ }
 =20
- 	return ret;
+ static int zonefs_remount(struct super_block *sb, int *flags, char *data)
+ {
+ 	sync_filesystem(sb);
+=20
+ 	return zonefs_parse_options(sb, data);
  }
 =20
 -static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 +static int zonefs_inode_setattr(struct mnt_idmap *idmap,
  				struct dentry *dentry, struct iattr *iattr)
  {
  	struct inode *inode =3D d_inode(dentry);
@@@ -641,8 -577,16 +577,16 @@@
  			return ret;
  	}
 =20
 -	setattr_copy(&init_user_ns, inode, iattr);
 +	setattr_copy(&nop_mnt_idmap, inode, iattr);
 =20
+ 	if (S_ISREG(inode->i_mode)) {
+ 		struct zonefs_zone *z =3D zonefs_inode_zone(inode);
+=20
+ 		z->z_mode =3D inode->i_mode;
+ 		z->z_uid =3D inode->i_uid;
+ 		z->z_gid =3D inode->i_gid;
+ 	}
+=20
  	return 0;
  }
 =20
@@@ -650,753 -594,194 +594,194 @@@ static const struct inode_operations zo
  	.setattr	=3D zonefs_inode_setattr,
  };
 =20
- static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
- 			     int datasync)
+ static long zonefs_fname_to_fno(const struct qstr *fname)
  {
- 	struct inode *inode =3D file_inode(file);
- 	int ret =3D 0;
-=20
- 	if (unlikely(IS_IMMUTABLE(inode)))
- 		return -EPERM;
+ 	const char *name =3D fname->name;
+ 	unsigned int len =3D fname->len;
+ 	long fno =3D 0, shift =3D 1;
+ 	const char *rname;
+ 	char c =3D *name;
+ 	unsigned int i;
 =20
  	/*
- 	 * Since only direct writes are allowed in sequential files, page cache
- 	 * flush is needed only for conventional zone files.
+ 	 * File names are always a base-10 number string without any
+ 	 * leading 0s.
  	 */
- 	if (ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
- 		ret =3D file_write_and_wait_range(file, start, end);
- 	if (!ret)
- 		ret =3D blkdev_issue_flush(inode->i_sb->s_bdev);
+ 	if (!isdigit(c))
+ 		return -ENOENT;
 =20
- 	if (ret)
- 		zonefs_io_error(inode, true);
+ 	if (len > 1 && c =3D=3D '0')
+ 		return -ENOENT;
 =20
- 	return ret;
- }
+ 	if (len =3D=3D 1)
+ 		return c - '0';
 =20
- static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
- {
- 	struct inode *inode =3D file_inode(vmf->vma->vm_file);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	vm_fault_t ret;
-=20
- 	if (unlikely(IS_IMMUTABLE(inode)))
- 		return VM_FAULT_SIGBUS;
-=20
- 	/*
- 	 * Sanity check: only conventional zone files can have shared
- 	 * writeable mappings.
- 	 */
- 	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
- 		return VM_FAULT_NOPAGE;
-=20
- 	sb_start_pagefault(inode->i_sb);
- 	file_update_time(vmf->vma->vm_file);
-=20
- 	/* Serialize against truncates */
- 	filemap_invalidate_lock_shared(inode->i_mapping);
- 	ret =3D iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
- 	filemap_invalidate_unlock_shared(inode->i_mapping);
-=20
- 	sb_end_pagefault(inode->i_sb);
- 	return ret;
- }
-=20
- static const struct vm_operations_struct zonefs_file_vm_ops =3D {
- 	.fault		=3D filemap_fault,
- 	.map_pages	=3D filemap_map_pages,
- 	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,
- };
-=20
- static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vma)
- {
- 	/*
- 	 * Conventional zones accept random writes, so their files can support
- 	 * shared writable mappings. For sequential zone files, only read
- 	 * mappings are possible since there are no guarantees for write
- 	 * ordering between msync() and page cache writeback.
- 	 */
- 	if (ZONEFS_I(file_inode(file))->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
- 	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
- 		return -EINVAL;
-=20
- 	file_accessed(file);
- 	vma->vm_ops =3D &zonefs_file_vm_ops;
-=20
- 	return 0;
- }
-=20
- static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int wh=
ence)
- {
- 	loff_t isize =3D i_size_read(file_inode(file));
-=20
- 	/*
- 	 * Seeks are limited to below the zone size for conventional zones
- 	 * and below the zone write pointer for sequential zones. In both
- 	 * cases, this limit is the inode size.
- 	 */
- 	return generic_file_llseek_size(file, offset, whence, isize, isize);
- }
-=20
- static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
- 					int error, unsigned int flags)
- {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-=20
- 	if (error) {
- 		zonefs_io_error(inode, true);
- 		return error;
- 	}
-=20
- 	if (size && zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
- 		/*
- 		 * Note that we may be seeing completions out of order,
- 		 * but that is not a problem since a write completed
- 		 * successfully necessarily means that all preceding writes
- 		 * were also successful. So we can safely increase the inode
- 		 * size to the write end location.
- 		 */
- 		mutex_lock(&zi->i_truncate_mutex);
- 		if (i_size_read(inode) < iocb->ki_pos + size) {
- 			zonefs_update_stats(inode, iocb->ki_pos + size);
- 			zonefs_i_size_write(inode, iocb->ki_pos + size);
- 		}
- 		mutex_unlock(&zi->i_truncate_mutex);
- 	}
-=20
- 	return 0;
- }
-=20
- static const struct iomap_dio_ops zonefs_write_dio_ops =3D {
- 	.end_io			=3D zonefs_file_write_dio_end_io,
- };
-=20
- static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter=
 *from)
- {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	struct block_device *bdev =3D inode->i_sb->s_bdev;
- 	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
- 	struct bio *bio;
- 	ssize_t size;
- 	int nr_pages;
- 	ssize_t ret;
-=20
- 	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
- 	iov_iter_truncate(from, max);
-=20
- 	nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
- 	if (!nr_pages)
- 		return 0;
-=20
- 	bio =3D bio_alloc(bdev, nr_pages,
- 			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
- 	bio->bi_iter.bi_sector =3D zi->i_zsector;
- 	bio->bi_ioprio =3D iocb->ki_ioprio;
- 	if (iocb_is_dsync(iocb))
- 		bio->bi_opf |=3D REQ_FUA;
-=20
- 	ret =3D bio_iov_iter_get_pages(bio, from);
- 	if (unlikely(ret))
- 		goto out_release;
-=20
- 	size =3D bio->bi_iter.bi_size;
- 	task_io_account_write(size);
-=20
- 	if (iocb->ki_flags & IOCB_HIPRI)
- 		bio_set_polled(bio, iocb);
-=20
- 	ret =3D submit_bio_wait(bio);
-=20
- 	/*
- 	 * If the file zone was written underneath the file system, the zone
- 	 * write pointer may not be where we expect it to be, but the zone
- 	 * append write can still succeed. So check manually that we wrote where
- 	 * we intended to, that is, at zi->i_wpoffset.
- 	 */
- 	if (!ret) {
- 		sector_t wpsector =3D
- 			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
-=20
- 		if (bio->bi_iter.bi_sector !=3D wpsector) {
- 			zonefs_warn(inode->i_sb,
- 				"Corrupted write pointer %llu for zone at %llu\n",
- 				wpsector, zi->i_zsector);
- 			ret =3D -EIO;
- 		}
- 	}
-=20
- 	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
- 	trace_zonefs_file_dio_append(inode, size, ret);
-=20
- out_release:
- 	bio_release_pages(bio, false);
- 	bio_put(bio);
-=20
- 	if (ret >=3D 0) {
- 		iocb->ki_pos +=3D size;
- 		return size;
- 	}
-=20
- 	return ret;
- }
-=20
- /*
-  * Do not exceed the LFS limits nor the file zone size. If pos is under t=
he
-  * limit it becomes a short access. If it exceeds the limit, return -EFBI=
G.
-  */
- static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
- 					loff_t count)
- {
- 	struct inode *inode =3D file_inode(file);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	loff_t limit =3D rlimit(RLIMIT_FSIZE);
- 	loff_t max_size =3D zi->i_max_size;
-=20
- 	if (limit !=3D RLIM_INFINITY) {
- 		if (pos >=3D limit) {
- 			send_sig(SIGXFSZ, current, 0);
- 			return -EFBIG;
- 		}
- 		count =3D min(count, limit - pos);
- 	}
-=20
- 	if (!(file->f_flags & O_LARGEFILE))
- 		max_size =3D min_t(loff_t, MAX_NON_LFS, max_size);
-=20
- 	if (unlikely(pos >=3D max_size))
- 		return -EFBIG;
-=20
- 	return min(count, max_size - pos);
- }
-=20
- static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *f=
rom)
- {
- 	struct file *file =3D iocb->ki_filp;
- 	struct inode *inode =3D file_inode(file);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	loff_t count;
-=20
- 	if (IS_SWAPFILE(inode))
- 		return -ETXTBSY;
-=20
- 	if (!iov_iter_count(from))
- 		return 0;
-=20
- 	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
- 		return -EINVAL;
-=20
- 	if (iocb->ki_flags & IOCB_APPEND) {
- 		if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
- 			return -EINVAL;
- 		mutex_lock(&zi->i_truncate_mutex);
- 		iocb->ki_pos =3D zi->i_wpoffset;
- 		mutex_unlock(&zi->i_truncate_mutex);
+ 	for (i =3D 0, rname =3D name + len - 1; i < len; i++, rname--) {
+ 		c =3D *rname;
+ 		if (!isdigit(c))
+ 			return -ENOENT;
+ 		fno +=3D (c - '0') * shift;
+ 		shift *=3D 10;
  	}
 =20
- 	count =3D zonefs_write_check_limits(file, iocb->ki_pos,
- 					  iov_iter_count(from));
- 	if (count < 0)
- 		return count;
-=20
- 	iov_iter_truncate(from, count);
- 	return iov_iter_count(from);
- }
-=20
- /*
-  * Handle direct writes. For sequential zone files, this is the only poss=
ible
-  * write path. For these files, check that the user is issuing writes
-  * sequentially from the end of the file. This code assumes that the bloc=
k layer
-  * delivers write requests to the device in sequential order. This is alw=
ays the
-  * case if a block IO scheduler implementing the ELEVATOR_F_ZBD_SEQ_WRITE
-  * elevator feature is being used (e.g. mq-deadline). The block layer alw=
ays
-  * automatically select such an elevator for zoned block devices during t=
he
-  * device initialization.
-  */
- static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter =
*from)
- {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	struct super_block *sb =3D inode->i_sb;
- 	bool sync =3D is_sync_kiocb(iocb);
- 	bool append =3D false;
- 	ssize_t ret, count;
-=20
- 	/*
- 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
- 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
- 	 * on the inode lock but the second goes through but is now unaligned).
- 	 */
- 	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !sync &&
- 	    (iocb->ki_flags & IOCB_NOWAIT))
- 		return -EOPNOTSUPP;
-=20
- 	if (iocb->ki_flags & IOCB_NOWAIT) {
- 		if (!inode_trylock(inode))
- 			return -EAGAIN;
- 	} else {
- 		inode_lock(inode);
- 	}
-=20
- 	count =3D zonefs_write_checks(iocb, from);
- 	if (count <=3D 0) {
- 		ret =3D count;
- 		goto inode_unlock;
- 	}
-=20
- 	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
- 		ret =3D -EINVAL;
- 		goto inode_unlock;
- 	}
-=20
- 	/* Enforce sequential writes (append only) in sequential zones */
- 	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ) {
- 		mutex_lock(&zi->i_truncate_mutex);
- 		if (iocb->ki_pos !=3D zi->i_wpoffset) {
- 			mutex_unlock(&zi->i_truncate_mutex);
- 			ret =3D -EINVAL;
- 			goto inode_unlock;
- 		}
- 		mutex_unlock(&zi->i_truncate_mutex);
- 		append =3D sync;
- 	}
-=20
- 	if (append)
- 		ret =3D zonefs_file_dio_append(iocb, from);
- 	else
- 		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
- 				   &zonefs_write_dio_ops, 0, NULL, 0);
- 	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
- 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
- 		if (ret > 0)
- 			count =3D ret;
-=20
- 		/*
- 		 * Update the zone write pointer offset assuming the write
- 		 * operation succeeded. If it did not, the error recovery path
- 		 * will correct it. Also do active seq file accounting.
- 		 */
- 		mutex_lock(&zi->i_truncate_mutex);
- 		zi->i_wpoffset +=3D count;
- 		zonefs_account_active(inode);
- 		mutex_unlock(&zi->i_truncate_mutex);
- 	}
-=20
- inode_unlock:
- 	inode_unlock(inode);
-=20
- 	return ret;
- }
-=20
- static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
- 					  struct iov_iter *from)
- {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	ssize_t ret;
-=20
- 	/*
- 	 * Direct IO writes are mandatory for sequential zone files so that the
- 	 * write IO issuing order is preserved.
- 	 */
- 	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV)
- 		return -EIO;
-=20
- 	if (iocb->ki_flags & IOCB_NOWAIT) {
- 		if (!inode_trylock(inode))
- 			return -EAGAIN;
- 	} else {
- 		inode_lock(inode);
- 	}
-=20
- 	ret =3D zonefs_write_checks(iocb, from);
- 	if (ret <=3D 0)
- 		goto inode_unlock;
-=20
- 	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
- 	if (ret > 0)
- 		iocb->ki_pos +=3D ret;
- 	else if (ret =3D=3D -EIO)
- 		zonefs_io_error(inode, true);
-=20
- inode_unlock:
- 	inode_unlock(inode);
- 	if (ret > 0)
- 		ret =3D generic_write_sync(iocb, ret);
-=20
- 	return ret;
+ 	return fno;
  }
 =20
- static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
+ static struct inode *zonefs_get_file_inode(struct inode *dir,
+ 					   struct dentry *dentry)
  {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
-=20
- 	if (unlikely(IS_IMMUTABLE(inode)))
- 		return -EPERM;
-=20
- 	if (sb_rdonly(inode->i_sb))
- 		return -EROFS;
-=20
- 	/* Write operations beyond the zone size are not allowed */
- 	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)
- 		return -EFBIG;
-=20
- 	if (iocb->ki_flags & IOCB_DIRECT) {
- 		ssize_t ret =3D zonefs_file_dio_write(iocb, from);
- 		if (ret !=3D -ENOTBLK)
- 			return ret;
- 	}
-=20
- 	return zonefs_file_buffered_write(iocb, from);
- }
-=20
- static int zonefs_file_read_dio_end_io(struct kiocb *iocb, ssize_t size,
- 				       int error, unsigned int flags)
- {
- 	if (error) {
- 		zonefs_io_error(file_inode(iocb->ki_filp), false);
- 		return error;
- 	}
-=20
- 	return 0;
- }
-=20
- static const struct iomap_dio_ops zonefs_read_dio_ops =3D {
- 	.end_io			=3D zonefs_file_read_dio_end_io,
- };
-=20
- static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter =
*to)
- {
- 	struct inode *inode =3D file_inode(iocb->ki_filp);
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	struct super_block *sb =3D inode->i_sb;
- 	loff_t isize;
- 	ssize_t ret;
-=20
- 	/* Offline zones cannot be read */
- 	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
- 		return -EPERM;
-=20
- 	if (iocb->ki_pos >=3D zi->i_max_size)
- 		return 0;
-=20
- 	if (iocb->ki_flags & IOCB_NOWAIT) {
- 		if (!inode_trylock_shared(inode))
- 			return -EAGAIN;
- 	} else {
- 		inode_lock_shared(inode);
- 	}
+ 	struct zonefs_zone_group *zgroup =3D dir->i_private;
+ 	struct super_block *sb =3D dir->i_sb;
+ 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+ 	struct zonefs_zone *z;
+ 	struct inode *inode;
+ 	ino_t ino;
+ 	long fno;
 =20
- 	/* Limit read operations to written data */
- 	mutex_lock(&zi->i_truncate_mutex);
- 	isize =3D i_size_read(inode);
- 	if (iocb->ki_pos >=3D isize) {
- 		mutex_unlock(&zi->i_truncate_mutex);
- 		ret =3D 0;
- 		goto inode_unlock;
- 	}
- 	iov_iter_truncate(to, isize - iocb->ki_pos);
- 	mutex_unlock(&zi->i_truncate_mutex);
+ 	/* Get the file number from the file name */
+ 	fno =3D zonefs_fname_to_fno(&dentry->d_name);
+ 	if (fno < 0)
+ 		return ERR_PTR(fno);
 =20
- 	if (iocb->ki_flags & IOCB_DIRECT) {
- 		size_t count =3D iov_iter_count(to);
+ 	if (!zgroup->g_nr_zones || fno >=3D zgroup->g_nr_zones)
+ 		return ERR_PTR(-ENOENT);
 =20
- 		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
- 			ret =3D -EINVAL;
- 			goto inode_unlock;
- 		}
- 		file_accessed(iocb->ki_filp);
- 		ret =3D iomap_dio_rw(iocb, to, &zonefs_read_iomap_ops,
- 				   &zonefs_read_dio_ops, 0, NULL, 0);
- 	} else {
- 		ret =3D generic_file_read_iter(iocb, to);
- 		if (ret =3D=3D -EIO)
- 			zonefs_io_error(inode, false);
+ 	z =3D &zgroup->g_zones[fno];
+ 	ino =3D z->z_sector >> sbi->s_zone_sectors_shift;
+ 	inode =3D iget_locked(sb, ino);
+ 	if (!inode)
+ 		return ERR_PTR(-ENOMEM);
+ 	if (!(inode->i_state & I_NEW)) {
+ 		WARN_ON_ONCE(inode->i_private !=3D z);
+ 		return inode;
  	}
 =20
- inode_unlock:
- 	inode_unlock_shared(inode);
-=20
- 	return ret;
- }
+ 	inode->i_ino =3D ino;
+ 	inode->i_mode =3D z->z_mode;
+ 	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;
+ 	inode->i_uid =3D z->z_uid;
+ 	inode->i_gid =3D z->z_gid;
+ 	inode->i_size =3D z->z_wpoffset;
+ 	inode->i_blocks =3D z->z_capacity >> SECTOR_SHIFT;
+ 	inode->i_private =3D z;
 =20
- /*
-  * Write open accounting is done only for sequential files.
-  */
- static inline bool zonefs_seq_file_need_wro(struct inode *inode,
- 					    struct file *file)
- {
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+ 	inode->i_op =3D &zonefs_file_inode_operations;
+ 	inode->i_fop =3D &zonefs_file_operations;
+ 	inode->i_mapping->a_ops =3D &zonefs_file_aops;
 =20
- 	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
- 		return false;
+ 	/* Update the inode access rights depending on the zone condition */
+ 	zonefs_inode_update_mode(inode);
 =20
- 	if (!(file->f_mode & FMODE_WRITE))
- 		return false;
+ 	unlock_new_inode(inode);
 =20
- 	return true;
+ 	return inode;
  }
 =20
- static int zonefs_seq_file_write_open(struct inode *inode)
+ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
+ 					     enum zonefs_ztype ztype)
  {
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	int ret =3D 0;
-=20
- 	mutex_lock(&zi->i_truncate_mutex);
-=20
- 	if (!zi->i_wr_refcnt) {
- 		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
- 		unsigned int wro =3D atomic_inc_return(&sbi->s_wro_seq_files);
-=20
- 		if (sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
-=20
- 			if (sbi->s_max_wro_seq_files
- 			    && wro > sbi->s_max_wro_seq_files) {
- 				atomic_dec(&sbi->s_wro_seq_files);
- 				ret =3D -EBUSY;
- 				goto unlock;
- 			}
+ 	struct inode *root =3D d_inode(sb->s_root);
+ 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+ 	struct inode *inode;
+ 	ino_t ino =3D bdev_nr_zones(sb->s_bdev) + ztype + 1;
 =20
- 			if (i_size_read(inode) < zi->i_max_size) {
- 				ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
- 				if (ret) {
- 					atomic_dec(&sbi->s_wro_seq_files);
- 					goto unlock;
- 				}
- 				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
- 				zonefs_account_active(inode);
- 			}
- 		}
- 	}
+ 	inode =3D iget_locked(sb, ino);
+ 	if (!inode)
+ 		return ERR_PTR(-ENOMEM);
+ 	if (!(inode->i_state & I_NEW))
+ 		return inode;
+=20
+ 	inode->i_ino =3D ino;
 -	inode_init_owner(&init_user_ns, inode, root, S_IFDIR | 0555);
++	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
+ 	inode->i_size =3D sbi->s_zgroup[ztype].g_nr_zones;
+ 	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D root->i_ctime;
+ 	inode->i_private =3D &sbi->s_zgroup[ztype];
+ 	set_nlink(inode, 2);
 =20
- 	zi->i_wr_refcnt++;
+ 	inode->i_op =3D &zonefs_dir_inode_operations;
+ 	inode->i_fop =3D &zonefs_dir_operations;
 =20
- unlock:
- 	mutex_unlock(&zi->i_truncate_mutex);
+ 	unlock_new_inode(inode);
 =20
- 	return ret;
+ 	return inode;
  }
 =20
- static int zonefs_file_open(struct inode *inode, struct file *file)
- {
- 	int ret;
-=20
- 	ret =3D generic_file_open(inode, file);
- 	if (ret)
- 		return ret;
-=20
- 	if (zonefs_seq_file_need_wro(inode, file))
- 		return zonefs_seq_file_write_open(inode);
-=20
- 	return 0;
- }
 =20
- static void zonefs_seq_file_write_close(struct inode *inode)
+ static struct inode *zonefs_get_dir_inode(struct inode *dir,
+ 					  struct dentry *dentry)
  {
- 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
- 	struct super_block *sb =3D inode->i_sb;
+ 	struct super_block *sb =3D dir->i_sb;
  	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
- 	int ret =3D 0;
-=20
- 	mutex_lock(&zi->i_truncate_mutex);
-=20
- 	zi->i_wr_refcnt--;
- 	if (zi->i_wr_refcnt)
- 		goto unlock;
+ 	const char *name =3D dentry->d_name.name;
+ 	enum zonefs_ztype ztype;
 =20
  	/*
- 	 * The file zone may not be open anymore (e.g. the file was truncated to
- 	 * its maximum size or it was fully written). For this case, we only
- 	 * need to decrement the write open count.
+ 	 * We only need to check for the "seq" directory and
+ 	 * the "cnv" directory if we have conventional zones.
  	 */
- 	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
- 		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
- 		if (ret) {
- 			__zonefs_io_error(inode, false);
- 			/*
- 			 * Leaving zones explicitly open may lead to a state
- 			 * where most zones cannot be written (zone resources
- 			 * exhausted). So take preventive action by remounting
- 			 * read-only.
- 			 */
- 			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
- 			    !(sb->s_flags & SB_RDONLY)) {
- 				zonefs_warn(sb,
- 					"closing zone at %llu failed %d\n",
- 					zi->i_zsector, ret);
- 				zonefs_warn(sb,
- 					"remounting filesystem read-only\n");
- 				sb->s_flags |=3D SB_RDONLY;
- 			}
- 			goto unlock;
- 		}
+ 	if (dentry->d_name.len !=3D 3)
+ 		return ERR_PTR(-ENOENT);
 =20
- 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
- 		zonefs_account_active(inode);
+ 	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+ 		if (sbi->s_zgroup[ztype].g_nr_zones &&
+ 		    memcmp(name, zonefs_zgroup_name(ztype), 3) =3D=3D 0)
+ 			break;
  	}
+ 	if (ztype =3D=3D ZONEFS_ZTYPE_MAX)
+ 		return ERR_PTR(-ENOENT);
 =20
- 	atomic_dec(&sbi->s_wro_seq_files);
-=20
- unlock:
- 	mutex_unlock(&zi->i_truncate_mutex);
- }
-=20
- static int zonefs_file_release(struct inode *inode, struct file *file)
- {
- 	/*
- 	 * If we explicitly open a zone we must close it again as well, but the
- 	 * zone management operation can fail (either due to an IO error or as
- 	 * the zone has gone offline or read-only). Make sure we don't fail the
- 	 * close(2) for user-space.
- 	 */
- 	if (zonefs_seq_file_need_wro(inode, file))
- 		zonefs_seq_file_write_close(inode);
-=20
- 	return 0;
+ 	return zonefs_get_zgroup_inode(sb, ztype);
  }
 =20
- static const struct file_operations zonefs_file_operations =3D {
- 	.open		=3D zonefs_file_open,
- 	.release	=3D zonefs_file_release,
- 	.fsync		=3D zonefs_file_fsync,
- 	.mmap		=3D zonefs_file_mmap,
- 	.llseek		=3D zonefs_file_llseek,
- 	.read_iter	=3D zonefs_file_read_iter,
- 	.write_iter	=3D zonefs_file_write_iter,
- 	.splice_read	=3D generic_file_splice_read,
- 	.splice_write	=3D iter_file_splice_write,
- 	.iopoll		=3D iocb_bio_iopoll,
- };
-=20
- static struct kmem_cache *zonefs_inode_cachep;
-=20
- static struct inode *zonefs_alloc_inode(struct super_block *sb)
+ static struct dentry *zonefs_lookup(struct inode *dir, struct dentry *den=
try,
+ 				    unsigned int flags)
  {
- 	struct zonefs_inode_info *zi;
-=20
- 	zi =3D alloc_inode_sb(sb, zonefs_inode_cachep, GFP_KERNEL);
- 	if (!zi)
- 		return NULL;
-=20
- 	inode_init_once(&zi->i_vnode);
- 	mutex_init(&zi->i_truncate_mutex);
- 	zi->i_wr_refcnt =3D 0;
- 	zi->i_flags =3D 0;
-=20
- 	return &zi->i_vnode;
- }
-=20
- static void zonefs_free_inode(struct inode *inode)
- {
- 	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
- }
-=20
- /*
-  * File system stat.
-  */
- static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
- {
- 	struct super_block *sb =3D dentry->d_sb;
- 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
- 	enum zonefs_ztype t;
+ 	struct inode *inode;
 =20
- 	buf->f_type =3D ZONEFS_MAGIC;
- 	buf->f_bsize =3D sb->s_blocksize;
- 	buf->f_namelen =3D ZONEFS_NAME_MAX;
+ 	if (dentry->d_name.len > ZONEFS_NAME_MAX)
+ 		return ERR_PTR(-ENAMETOOLONG);
 =20
- 	spin_lock(&sbi->s_lock);
-=20
- 	buf->f_blocks =3D sbi->s_blocks;
- 	if (WARN_ON(sbi->s_used_blocks > sbi->s_blocks))
- 		buf->f_bfree =3D 0;
+ 	if (dir =3D=3D d_inode(dir->i_sb->s_root))
+ 		inode =3D zonefs_get_dir_inode(dir, dentry);
  	else
- 		buf->f_bfree =3D buf->f_blocks - sbi->s_used_blocks;
- 	buf->f_bavail =3D buf->f_bfree;
+ 		inode =3D zonefs_get_file_inode(dir, dentry);
+ 	if (IS_ERR(inode))
+ 		return ERR_CAST(inode);
 =20
- 	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {
- 		if (sbi->s_nr_files[t])
- 			buf->f_files +=3D sbi->s_nr_files[t] + 1;
- 	}
- 	buf->f_ffree =3D 0;
-=20
- 	spin_unlock(&sbi->s_lock);
-=20
- 	buf->f_fsid =3D uuid_to_fsid(sbi->s_uuid.b);
-=20
- 	return 0;
+ 	return d_splice_alias(inode, dentry);
  }
 =20
- enum {
- 	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
- 	Opt_explicit_open, Opt_err,
- };
-=20
- static const match_table_t tokens =3D {
- 	{ Opt_errors_ro,	"errors=3Dremount-ro"},
- 	{ Opt_errors_zro,	"errors=3Dzone-ro"},
- 	{ Opt_errors_zol,	"errors=3Dzone-offline"},
- 	{ Opt_errors_repair,	"errors=3Drepair"},
- 	{ Opt_explicit_open,	"explicit-open" },
- 	{ Opt_err,		NULL}
- };
-=20
- static int zonefs_parse_options(struct super_block *sb, char *options)
+ static int zonefs_readdir_root(struct file *file, struct dir_context *ctx)
  {
+ 	struct inode *inode =3D file_inode(file);
+ 	struct super_block *sb =3D inode->i_sb;
  	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
- 	substring_t args[MAX_OPT_ARGS];
- 	char *p;
+ 	enum zonefs_ztype ztype =3D ZONEFS_ZTYPE_CNV;
+ 	ino_t base_ino =3D bdev_nr_zones(sb->s_bdev) + 1;
 =20
- 	if (!options)
+ 	if (ctx->pos >=3D inode->i_size)
  		return 0;
 =20
- 	while ((p =3D strsep(&options, ",")) !=3D NULL) {
- 		int token;
+ 	if (!dir_emit_dots(file, ctx))
+ 		return 0;
 =20
- 		if (!*p)
- 			continue;
+ 	if (ctx->pos =3D=3D 2) {
+ 		if (!sbi->s_zgroup[ZONEFS_ZTYPE_CNV].g_nr_zones)
+ 			ztype =3D ZONEFS_ZTYPE_SEQ;
 =20
- 		token =3D match_token(p, tokens, args);
- 		switch (token) {
- 		case Opt_errors_ro:
- 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
- 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_RO;
- 			break;
- 		case Opt_errors_zro:
- 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
- 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_ZRO;
- 			break;
- 		case Opt_errors_zol:
- 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
- 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_ZOL;
- 			break;
- 		case Opt_errors_repair:
- 			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;
- 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_REPAIR;
- 			break;
- 		case Opt_explicit_open:
- 			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_EXPLICIT_OPEN;
- 			break;
- 		default:
- 			return -EINVAL;
- 		}
+ 		if (!dir_emit(ctx, zonefs_zgroup_name(ztype), 3,
+ 			      base_ino + ztype, DT_DIR))
+ 			return 0;
+ 		ctx->pos++;
  	}
 =20
- 	return 0;
- }
-=20
- static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
- {
- 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(root->d_sb);
-=20
- 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO)
- 		seq_puts(seq, ",errors=3Dremount-ro");
- 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO)
- 		seq_puts(seq, ",errors=3Dzone-ro");
- 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL)
- 		seq_puts(seq, ",errors=3Dzone-offline");
- 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_REPAIR)
- 		seq_puts(seq, ",errors=3Drepair");
+ 	if (ctx->pos =3D=3D 3 && ztype !=3D ZONEFS_ZTYPE_SEQ) {
+ 		ztype =3D ZONEFS_ZTYPE_SEQ;
+ 		if (!dir_emit(ctx, zonefs_zgroup_name(ztype), 3,
+ 			      base_ino + ztype, DT_DIR))
+ 			return 0;
+ 		ctx->pos++;
+ 	}
 =20
  	return 0;
  }

--Sig_/52Nzbp3idqTfgnppX/j5PCf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPA1cACgkQAVBC80lX
0GxOQAgAimDlw9M+hn+ou+/JBUwUhJmwwSwicFktyWJPyu0R/gIVz9D7YvKuEkTO
fLkgdli+GTfQ4pbvGUpLeWe48LzRUcdrdZQ78B2//q8K+ZuB07lay+rw977QNASb
1rHAED6ibNGJRLkjhNErD98pJQvKD4y9gJYeZfMsA3SjgHJE8KqlMMsX6TVc/Gck
shtyb2mt0r+2qpAUcu17jQgtlikt8G1jOa7F/zauDftFJjL31sZU6m4BkLvRhaXn
7fSoHPX4bwJjMyfSnRzzUn3Yq52Cg6uHYc59UB52ltZe8zr5JIZFGaTfOQPpuqro
YoeGY91QMxFpZPiHUI1ILqQigdne7g==
=aYTi
-----END PGP SIGNATURE-----

--Sig_/52Nzbp3idqTfgnppX/j5PCf--
