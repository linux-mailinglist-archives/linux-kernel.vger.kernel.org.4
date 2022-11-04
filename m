Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784861A1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKDT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKDT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:57:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BC42F61;
        Fri,  4 Nov 2022 12:57:54 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4JCgn6016497;
        Fri, 4 Nov 2022 19:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version; s=pp1; bh=gVUMAyNfyBHsAu6j1Gg/8/sMPkogRA989Ci/S2OviWs=;
 b=s4TpWd0iSPz9YTQZy2dfPkujDUYH6e951BDDK0AU7fYnBsxOOfYIbTR5/AKxqa5cgdFn
 qiOX9Wf70p3b7jjLFbeu/iLD7sVe8+5F9M/5w26AOImQLJEb9Lmnvc3NysFHP9HH2OMY
 4vKTe2fOgCi4jaorgm4ODrFEeaOzmlu/RND45L+kdC7Mb7BHgS8nU5KcA0kjjshDoJdr
 3Z82AtWwUPtZGfWu+2vv4bVJ4xRpZdaTO0eSyS8SaVJk3qk4+Sa+CsEy7jxi+qjBg8Me
 HpxiqgSnwEVZzazGciqyj90zE9hU5MUVGhUZAr1nXjDTciujUxq4naiuWyIIgqp846Q4 BA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphkvg6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:57:29 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4Jonml010275;
        Fri, 4 Nov 2022 19:57:28 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutb4rpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:57:28 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A4JvPFG19399364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Nov 2022 19:57:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25A257805E;
        Fri,  4 Nov 2022 20:48:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272607805C;
        Fri,  4 Nov 2022 20:48:00 +0000 (GMT)
Received: from [IPv6:2607:fb90:18d2:c66c:f548:19c9:dbfe:c63e] (unknown [9.163.9.146])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  4 Nov 2022 20:48:00 +0000 (GMT)
Message-ID: <44fa41b4d69219b89e805d572df486c4dda77f08.camel@linux.ibm.com>
Subject: Re: [PATCH v2 14/15] scsi: ncr53c8xx: replace CCB_MAGIC with bool
 busy
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-scsi@vger.kernel.org
Date:   Fri, 04 Nov 2022 15:57:20 -0400
In-Reply-To: <27cefe163e602f7d5b35ba2e966dccf9109798f9.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
         <27cefe163e602f7d5b35ba2e966dccf9109798f9.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-etNRDRXkW8HpUsBOeo87"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rc7532kmBAGUIV5yfNQpPZCd0DJRYcWr
X-Proofpoint-GUID: Rc7532kmBAGUIV5yfNQpPZCd0DJRYcWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=825 phishscore=0 spamscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-etNRDRXkW8HpUsBOeo87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2022-11-02 at 00:06 +0100, Ahelenia Ziemia=C5=84ska wrote:
[...]
> @@ -4356,7 +4347,7 @@ static int ncr_queue_command (struct ncb *np,
> struct scsi_cmnd *cmd)
>  	*/
> =20
>  	/* activate this job.  */
> -	cp->magic		=3D CCB_MAGIC;
> +	cp->busy		=3D true;
> =20
>  	/*
>  	**	insert next CCBs into start queue.

Are you sure this is just an internal magic number?  The way these old
scripts engines used to work is that the CCB array forms a mailbox and
the card continually scans the mailbox to see if it has any work to do.
These magic values are often a signal to the card that the CCB array
contains a valid entry it hasn't seen and it should work on it, so the
card might be expecting to see this full 32 bit value.

Regards,

James


--=-etNRDRXkW8HpUsBOeo87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCY2VuoAAKCRDnQslM7pis
hVDrAQCv8/jATBzaYKZVhqN4ejDgR/IUcPhhQeKvZnS9ymN3xAEA6AMrn3sh6oEg
3KGbGxi0YmbenoSmKOSTagd/aZxmYAM=
=tuFV
-----END PGP SIGNATURE-----

--=-etNRDRXkW8HpUsBOeo87--

